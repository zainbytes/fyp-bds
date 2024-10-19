import 'package:flutter/material.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class LocationPicker extends StatefulWidget {
  final LatLng? location;
  const LocationPicker({this.location,super.key});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  LatLng? mark;
  var mapCont =MapController();

  @override
  void initState() {
    if (widget.location!=null) {
      mark=widget.location;
      
    }
    
    // TODO: implement initState
    super.initState();
  }
  

  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Pick location',
        actions: [
          saveButton(onPressed: (){
            Navigator.of(context).pop('${mark!.latitude},${mark!.longitude}');
          })
        ],),
      body: FlutterMap(
        mapController: mapCont,
        options: MapOptions(
          
          
            onTap: (tapPosition, point) {
              setState(() {
                mark = point;
              });
              
            },
            
            initialCenter: mark??const LatLng(31.5204,74.3587),
            initialZoom: 10,
            minZoom: 0,
            maxZoom: 19),
        children: [
          TileLayer(

            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            maxZoom: 19,
          ),
          MarkerLayer(markers: [
            
            Marker(
                point: mark ?? const LatLng(0,0),
                width: 80,
                height: 80,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 50,
                  
                ))
          ])
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          var position= await _determinePosition();
          mark=LatLng(position.latitude,position.longitude);
          mapCont.fitCamera(CameraFit.coordinates(
            maxZoom: 13,
            coordinates: [
            mark!,
          ]));
          setState(() {
          
        });},
        child: const Icon(Icons.location_searching),
        ),
    );
  }
  Padding saveButton({required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: TextButton(
          style: ButtonStyle(
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
              foregroundColor: const MaterialStatePropertyAll(Colors.red),
              backgroundColor: MaterialStatePropertyAll(Colors.red.shade100)),
          onPressed: onPressed,
          child: const Text('Save')),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var position=await Geolocator.getCurrentPosition();

   
    return position;
  }
}
