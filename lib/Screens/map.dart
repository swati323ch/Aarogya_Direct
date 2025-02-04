import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:arogya_direct/Screens/map_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer<
      GoogleMapController>(); //Controller controls the map actions like position of it etc

  final _firestore = FirebaseFirestore.instance;

  LatLng currentLocation =
      const LatLng(37.422131, -122.084801); //Latitude longitude of the college

  late BitmapDescriptor currentIcon =
      BitmapDescriptor.defaultMarker; //Not working {Custom Marker for the user}

  LatLng initialLocation =
      const LatLng(37.422131, -122.084801); //initial location of the marker

  Set<Circle> circles_ = {
//Set of circles which will be shown to the client of different users near that region
  };

  @override
  void initState() {
    setMarker();
    _locationListner();
    super.initState();
  }

  //listen for location updates using GeoLocator
  Future<void> _locationListner() async {
    final GoogleMapController controller = await _controller.future;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Permission denied ");
      }
    }

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 0,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) async {
      await controller
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position!.latitude, position.longitude),
        zoom: 17,
      )));
      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'name': 'wick'
      });

      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
      });
    });
  }

  void setMarker() async {
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/marker.png')
        .then((icon) {
      currentIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        mapType: MapType.normal,
        compassEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 14,
        ),
        markers: {
          Marker(
              markerId: MarkerId("currentPos"),
              position:
                  LatLng(currentLocation.latitude, currentLocation.longitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure))
        },
        circles: {
          Circle(
            circleId: const CircleId("Larger"),
            center: LatLng(currentLocation.latitude, currentLocation.longitude),
            radius: 100,
            strokeWidth: 0,
            fillColor: const Color.fromARGB(31, 1, 134, 251),
          ),
          Circle(
            circleId: const CircleId("Smaller"),
            center: LatLng(currentLocation.latitude, currentLocation.longitude),
            radius: 40,
            strokeWidth: 0,
            fillColor: const Color.fromARGB(53, 4, 123, 241),
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          controller.setMapStyle(MapStyle().dark);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: null,
        child: Container(
          height: 75,
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
                IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
              ]),
        ),
      ),
    );
  }

  Future<void> addUsers() async {}
}
