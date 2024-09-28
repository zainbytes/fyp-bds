import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:latlong2/latlong.dart';

class ViewMap extends StatelessWidget {
  final LatLng location;
  const ViewMap({required this.location,super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:const CustomAppbar(title: 'View on map'),
      body: FlutterMap(
        options: MapOptions(
            initialCenter: location,
            initialZoom: 15,
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
                point: location,
                width: 80,
                height: 80,
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 50,
                ))
          ])
        ],
      ),
    );
  }
}
