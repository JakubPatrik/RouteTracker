import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

import '../SharedPref.dart';

const double CAMERA_ZOOM = 15;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

class MapPageHistory extends StatelessWidget {
  final String route;
  MapPageHistory(this.route);

  SharedPref sharedPref = SharedPref();

  GoogleMapController _controller;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  List<LatLng> trackCoordinates = [];
  LatLng source;

  String _mapStyle;
  

  Future<LatLng> fetchRoute(String route) async{
    List list = json.decode(json.decode(await sharedPref.read(route)));
    trackCoordinates.clear();
    list.forEach((element) {
      trackCoordinates.add(fromJson(element));});


      Polyline polyline = Polyline(
          polylineId: PolylineId(DateTime.now().millisecond.toString()),
          color: Color.fromARGB(255, 105, 25, 48),
          points: trackCoordinates,
          width: 5,
      );
      _polylines.clear();
      _polylines.add(polyline);

    source = trackCoordinates[(trackCoordinates.length~/2)];
    return source;
  }


  @override
  Widget build(BuildContext context) {
    //debugPrint("Now Building :$route");
    return Stack(
        children: <Widget>[
          /*
          FutureBuilder(
          future: fetchRoute(route),
          builder: (context,snapshot){
           return snapshot.data==null
             ? Center(child:CircularProgressIndicator(backgroundColor: Colors.deepOrangeAccent,))
             : GoogleMap(
            markers: _markers,
            polylines: _polylines,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              zoom: CAMERA_ZOOM,
              bearing: CAMERA_BEARING,
              tilt: CAMERA_TILT,
              target: snapshot.data
            ),
            onMapCreated: onMapCreated,
            myLocationEnabled: true,
            compassEnabled: true,
            tiltGesturesEnabled: false,
            rotateGesturesEnabled: false,
            myLocationButtonEnabled: false,
            );}
          ),
          Positioned(
            left:30,top:30,
            child: Column(
              children: <Widget>[
                Text("see it.",
                  style: TextStyle(color: Colors.black, fontSize: 48.0,fontFamily: 'Corbel',fontWeight: FontWeight.bold),
                ),
                Container(color:Colors.red,width:100,height: 4,)
              ]
            )),
          */
        ],
    );
  }



  onMapCreated(GoogleMapController controller) {
    _controller = controller;
    controller.setMapStyle(_mapStyle);
  }

  LatLng fromJson(Map<String,dynamic> json){
    return LatLng(json["latitude"],json["longitude"]);
  }

}