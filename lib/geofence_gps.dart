import 'dart:async';
import 'package:Keron_Sensors_Finalexam/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class GpsTrackerScreen extends StatefulWidget {
  static const routeName = '/gps_tracker';
  const GpsTrackerScreen({Key? key, this.showAppBarAndDrawer = true})
      : super(key: key);

  final bool showAppBarAndDrawer;

  @override
  _GpsTrackerScreenState createState() => _GpsTrackerScreenState();
}

class _GpsTrackerScreenState extends State<GpsTrackerScreen> {
  Location _locationController = Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  LatLng home =
      LatLng(-2.0024714434654034, 30.12547408465507); // Coordinates to my home
  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  static const LatLng _pApplePark = LatLng(37.3346, -122.0090);
  LatLng? _currentP;
  Map<PolylineId, Polyline> polylines = {};
  Map<PolygonId, Polygon> _polygons = {};
  StreamSubscription<LocationData>? _locationSubscription;
  bool _notificationSentOutSide = false;
  bool _notificationSentInSide = false;

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then(
      (_) => {
        getPolylinePoints().then((coordinates) => {
              generatePolyLineFromPoints(coordinates),
            }),
      },
    );
    _createGeofence();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: widget.showAppBarAndDrawer
          ? AppBar(
              backgroundColor: Colors.blue,
              title: Text('Your Location'),
            )
          : null,
      drawer: widget.showAppBarAndDrawer
          ? DrawerScreen(
              currentScreen: 'GPS Tracker',
            )
          : null,
      body: _currentP == null
          ? const Center(
              child: Text("Loading..."),
            )
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: CameraPosition(
                target: home,
                zoom: 14.0,
              ),
              polygons: Set<Polygon>.of(_polygons.values),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: {
                Marker(
                    markerId: MarkerId("source Location"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _pGooglePlex),
                Marker(
                    markerId: MarkerId("_destionationLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _pApplePark)
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void _triggerInSideNotification() async {
    if (!_notificationSentInSide) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'Map_channel', // Change this to match your channel ID
        'Map Notifications', // Replace with your own channel name
        importance: Importance.max,
        priority: Priority.high,
      );
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        0,
        'Entry Detected',
        'Entered Home Geographical Boundary',
        platformChannelSpecifics,
      );
      print('Entry notification sent');
      _notificationSentInSide = true;
      _notificationSentOutSide = false;
    }
  }

  void _triggerOutSideNotification() async {
    if (!_notificationSentOutSide) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'Map_channel', // Change this to match your channel ID
        'Map Notifications', // Replace with your own channel name
        importance: Importance.max,
        priority: Priority.high,
      );
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        0,
        'Exit Detected!!!',
        'Exited Home Geographical Boundaries.',
        platformChannelSpecifics,
      );
      print('Exit notification sent');
      _notificationSentOutSide = true;
      _notificationSentInSide = false;
    }
  }

  void _createGeofence() {
    List<LatLng> homeBoundaries = [
      LatLng(-2.003169, 30.125144),
      LatLng(-2.003263, 30.125040),
      LatLng(-2.003337, 30.125129),
      LatLng(-2.003252, 30.125234),
    ];

    // Create a polygon to represent the geofence boundaries
    PolygonId polygonId = PolygonId('HOME');
    Polygon polygon = Polygon(
      polygonId: polygonId,
      points: homeBoundaries,
      strokeWidth: 2,
      strokeColor: Colors.blue,
      fillColor: Colors.blue.withOpacity(0.3),
    );

    // Add the polygon to the map
    setState(() {
      _polygons[polygonId] = polygon;
    });

    // Start location updates subscription to monitor device's location
    _startLocationUpdates();
  }

  void _startLocationUpdates() async {
    _locationSubscription = _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      // Check if the device's location is inside or outside the geofence
      bool insideGeofence = _isLocationInsideGeofence(
          currentLocation.latitude!, currentLocation.longitude!);

      if (insideGeofence && !_notificationSentInSide) {
        _triggerInSideNotification();
        _notificationSentInSide = true;
        _notificationSentOutSide = false;
      } else if (!insideGeofence && !_notificationSentOutSide) {
        _triggerOutSideNotification();
        _notificationSentOutSide = true;
        _notificationSentInSide = false;
      }
    });
  }

  bool _isLocationInsideGeofence(double latitude, double longitude) {
    // Check if the provided location is inside the geofence boundaries
    bool isInside = false;
    List<LatLng> homeBoundaries = [
      LatLng(-2.003169, 30.125144),
      LatLng(-2.003263, 30.125040),
      LatLng(-2.003337, 30.125129),
      LatLng(-2.003252, 30.125234),
    ];

    // Algorithm to determine if a point is inside a polygon
    int i, j = homeBoundaries.length - 1;
    for (i = 0; i < homeBoundaries.length; i++) {
      if ((homeBoundaries[i].latitude < latitude &&
                  homeBoundaries[j].latitude >= latitude ||
              homeBoundaries[j].latitude < latitude &&
                  homeBoundaries[i].latitude >= latitude) &&
          (homeBoundaries[i].longitude <= longitude ||
              homeBoundaries[j].longitude <= longitude)) {
        if (homeBoundaries[i].longitude +
                (latitude - homeBoundaries[i].latitude) /
                    (homeBoundaries[j].latitude - homeBoundaries[i].latitude) *
                    (homeBoundaries[j].longitude -
                        homeBoundaries[i].longitude) <
            longitude) {
          isInside = !isInside;
        }
      }
      j = i;
    }
    return isInside;
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: await controller.getZoomLevel(), // Keep the current zoom level
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationSubscription = _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        LatLng newLocation =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);

        // Update the marker to the new location
        updateMarkerAndCircle(newLocation);

        // Optionally, keep track of the path by adding to your polyline
        addLocationToPolyline(newLocation);

        _cameraToPosition(newLocation);
      }
    });
  }

  void updateMarkerAndCircle(LatLng newLocation) {
    setState(() {
      _currentP = newLocation;
      // Update your marker or create a new one if needed
    });
  }

  void addLocationToPolyline(LatLng newLocation) {
    setState(() {
      // Check if polyline exists, if not create one
      if (polylines.containsKey(PolylineId("path"))) {
        final polyline = polylines[PolylineId("path")]!;
        final updatedPoints = List<LatLng>.from(polyline.points)
          ..add(newLocation);
        polylines[PolylineId("path")] =
            polyline.copyWith(pointsParam: updatedPoints);
      } else {
        // Create new polyline if it doesn't exist
        polylines[PolylineId("path")] = Polyline(
          polylineId: PolylineId("path"),
          color: Colors.blue,
          points: [newLocation],
          width: 5,
        );
      }
    });
  }

  static const String GOOGLE_MAPS_API_KEY =
      "AIzaSyDFNXP5T7xgH6z0E5_BjuCYwBoiSJjLZzE";

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
      PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }
}
