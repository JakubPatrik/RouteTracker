import 'dart:convert';
import 'dart:async';
import 'dart:core';

import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:intl/intl.dart';

import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/models/route.dart';
import 'package:myapp/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../SharedPref.dart';


class MainMap extends StatefulWidget {
  final bool history;
  MainMap(this.history);
  @override
  State<StatefulWidget> createState() => _MainMap();
}

class _MainMap extends State<MainMap> {
  SharedPref sharedPref = SharedPref();

  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  LatLng sourceLocation;

  int numOfdays = 0;
  bool start = false;

  String googleAPIKey = "AIzaSyDVvQzjFC8kPMUgWpw_6bP-xNYmDIAElrc";
  String route = "route_1304";
  String date = "";

  LocationData currentLocationA;
  LocationData currentLocationB;
  LocationData startLocation;
  Location location;
  StreamSubscription<LocationData> locationSubscription;

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Track> trackList;
  List<String> dates = new List<String>();


    @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    databaseHelper.getCount().then((value) => setState((){
      numOfdays = value;
    }));
    databaseHelper.getDates().then((value) => value.forEach((element) {setState(() {
      dates.add(element['date']);
    });}));
    location = new Location();
    locationSubscription = location.onLocationChanged.listen((LocationData cLoc) {
      currentLocationB = cLoc;
      sourceLocation = LatLng(cLoc.latitude,cLoc.longitude);
      //updatePinOnMap();
      if (start) {setPolylines();}
    });
  }

  @override
  void dispose() {
    super.dispose();
    locationSubscription.cancel();
    //polylineCoordinates.clear();
  }

  saveRoute() async{
    String route = jsonEncode(polylineCoordinates.map((i) => toJson(i)).toList()).toString();
    String dateString = DateFormat.Md().format(DateTime.now());

    debugPrint("SAVED Track consists of :" + route);
    Track track = new Track(dateString,route);
    debugPrint(dateString);
//    int r = await databaseHelper.deleteTrack(3);
//    r != 0 ? debugPrint("SUCCESS") : debugPrint("FAIL");
    int result = await databaseHelper.insertTrack(track);
    result != 0 ? debugPrint("SUCCESS") : debugPrint("FAIL");

    databaseHelper.getCount().then((value) => setState((){
      numOfdays = value;
    }));
    databaseHelper.getDates().then((value) => value.forEach((element) {setState(() {
      dates.add(element['date']);
    });}));
    setState(() {
      start = false;
    });
  }

  LocationData ld;
  Future getLocation() async {
    location = new Location();
    ld = await location.getLocation();
    return LatLng(ld.latitude,ld.longitude);
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Track>> trackListFuture = databaseHelper.getRoutesByDate(date);
      trackListFuture.then((trackList) {
        setState(() {
          this.trackList = trackList;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (trackList == null) {
      trackList = List<Track>();
      updateListView();
    }

    return FutureBuilder(
      future: getLocation(),
      builder: (context,snapshot){
        return snapshot.data==null
          ? Center(child:CircularProgressIndicator(backgroundColor: Colors.tealAccent,))
          : map(snapshot.data);
      },
    );
  }

  Widget map(LatLng source){
    return Stack(
      children: <Widget>[
        Container(
          child: googleMap(source, widget.history),
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
        Positioned(
          right:10,top:30,
          child: FloatingActionButton(
            heroTag: "location",
            child: Icon(Icons.my_location),
            onPressed: goToCurrentLocation,
          ),),
        Positioned(
          right:10,top:100,
          child: FloatingActionButton(
            heroTag: "save_route",
            child: Icon(Icons.save_alt,color: Colors.white,),
            onPressed: () => saveRoute(),
          ),)
      ]
    );
  }

  Widget googleMap(LatLng source, bool showHistory){
    return Stack(
      children: <Widget>[
        FutureBuilder(
          future: fetchRoute(),
          builder: (context,snapshot){
            return GoogleMap(
              markers: _markers,
              polylines: !showHistory ? _polylines : _polylinesH,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                zoom: 15, bearing: 0, tilt: 30,
                target: source
              ),
              onMapCreated: onMapCreated,
              tiltGesturesEnabled: false,
              mapToolbarEnabled: false,
              compassEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            );}
        ),
        showHistory ? cards() : SizedBox.shrink(),
      ]
    );
  }


  Widget cards(){
    return Column(
      children:<Widget>[
        SizedBox(height: 500,),
        Container(height:150,child:ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: numOfdays, itemBuilder: (context, index) {
          return Container(
            child: FlatButton(
              onPressed: () => setState((){
                date = dates[index];
                fetchRoute();
                debugPrint(date);
              }),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/card_0${(index%4)+1}.jpg"),
                    colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.15), BlendMode.screen),
                    fit: BoxFit.fill),
                  gradient: LinearGradient(
                    colors: [Colors.blue,Colors.blueGrey]),
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue,
                ),
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Center(child: Text(dates[index],
                  style: TextStyle(color: Colors.white, fontSize: 32.0,fontFamily: 'Corbel'),)),
              ),
            ),
          );
        }
      ))
    ]);
  }

//----------------------FUNCTIONS------------------------------------>


  Future<void> goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      zoom: 15,tilt: 25,bearing:30,
      target: LatLng(currentLocationB.latitude,
        currentLocationB.longitude),)));
    setState(() {
      start = true;
    });
    debugPrint(start.toString());
  }

  onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    showPinsOnMap();
    setPolylines();
  }

  showPinsOnMap() async {
    startLocation = await location.getLocation();
    currentLocationA = startLocation;
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('start'),
        position: LatLng(startLocation.latitude,
          startLocation.longitude),
        infoWindow: InfoWindow(
          title: "Start location",
          snippet: "start",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      ));
    });
  }

  setPolylines() async {
    LatLng point = LatLng(
      currentLocationB.latitude,
      currentLocationB.longitude);
    if (point != null) {
      polylineCoordinates.add(point);
      debugPrint(point.toString());
      }
    if(currentLocationA != currentLocationB){
      setState(() {
        Polyline polyline = Polyline(
          polylineId: PolylineId(DateTime
            .now()
            .millisecond
            .toString()),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates
        );
        _polylines.add(polyline);
      });
    }

    currentLocationA = currentLocationB;
  }

  updatePinOnMap() async {
    LatLng pinPosition = LatLng(currentLocationB.latitude,
      currentLocationB.longitude);
    CameraPosition cPosition = CameraPosition(
      zoom: 15,tilt: 0,bearing:30,
      target: pinPosition,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == 'curr');
      _markers.add(Marker(
        markerId: MarkerId('curr'),
        position: pinPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ));
    });
  }


  Map<String,dynamic> toJson(LatLng point){
    return {
      "latitude": point.latitude,
      "longitude": point.longitude,
    };
  }

//------------------FROM HISTORY--------------------------------->

  List<LatLng> trackCoordinates = [];
  LatLng source;

  Set<Polyline> _polylinesH = {};

  Future<LatLng> fetchRoute() async {
    List<Track> routeList = await databaseHelper.getRoutesByDate(date);
    trackCoordinates.clear();
    //databaseHelper.fuckme();

    for (int i = 0; i < routeList.length; i++) {
      List list = json.decode(routeList[i].route);
      list.forEach((element) {
        trackCoordinates.add(fromJson(element));
      });

      setState(() {
        Polyline polyline = Polyline(
          polylineId: PolylineId(DateTime
            .now()
            .millisecond
            .toString()),
          color: Color.fromARGB(255, 105, 25, 48),
          points: trackCoordinates,
          width: 5,
        );
        _polylinesH.add(polyline);
      });
    }

//    source = trackCoordinates[(
//      trackCoordinates.length ~/ 2
//    )];
    return LatLng(40.64147, -73.959460);

  }

  LatLng fromJson(Map<String,dynamic> json){
    return LatLng(json["latitude"],json["longitude"]);
  }

}