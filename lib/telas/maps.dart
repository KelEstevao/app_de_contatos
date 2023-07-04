import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  LatLng? _currentLocation;

  final LatLng _ifpiTeresinaCentro = LatLng(-5.085129, -42.801697);
  final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(-5.085129, -42.801697),
    zoom: 11.0,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _addMarkers();
  }

  void _getCurrentLocation() async {
    Location().getLocation().then((locationData) {
      setState(() {
        _currentLocation =
            LatLng(locationData.latitude!, locationData.longitude!);
      });
    });
  }

  void _addMarkers() {
    _markers.add(
      Marker(
        markerId: MarkerId('ifpi_teresina_centro'),
        position: _ifpiTeresinaCentro,
        infoWindow: InfoWindow(title: 'IFPI Teresina Centro'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );

    if (_currentLocation != null) {
      _markers.add(
        Marker(
          markerId: MarkerId('current_location'),
          position: _currentLocation!,
          infoWindow: InfoWindow(title: 'Minha localização'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
        backgroundColor: Colors.amber,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: _initialCameraPosition,
        markers: _markers,
        myLocationEnabled: true,
        mapType: MapType.hybrid,
      ),
    );
  }
}
