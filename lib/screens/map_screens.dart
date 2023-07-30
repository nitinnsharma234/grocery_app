
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_app/screens/store_viewModel.dart';

class StoreMapScreen extends StatefulWidget {
  final Store store;
  const StoreMapScreen({required this.store,super.key});

  @override
  State<StoreMapScreen> createState() => _StoreMapScreenState();
}

class _StoreMapScreenState extends State<StoreMapScreen> {
  late GoogleMapController mapController;

  //final LatLng _center =  LatLng(widget.store.lat!.toDouble(), widget.store.long.toDouble());

  Map<String ,Marker>_markers={};

  late LatLng _center ;


@override
  void initState() {
  print( widget.store.lat!.toDouble());
  _center =  LatLng( widget.store.lat!.toDouble(),widget.store.long!.toDouble() );
  print("${_center.latitude} and ${_center.longitude}");

  }
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    addMarkers("test",_center);
  }
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 14,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }

  Future<void> addMarkers(String id, LatLng location) async {
    var markerIcon= await BitmapDescriptor.fromAssetImage(const ImageConfiguration(), "assets/images/shop.png");
    var marker=Marker(markerId: MarkerId(id),position: location,icon: markerIcon);
    _markers[id]=marker;
    setState(() {

    });
  }
}