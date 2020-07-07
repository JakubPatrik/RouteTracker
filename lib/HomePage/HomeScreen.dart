import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:myapp/SharedPref.dart';

import 'MainMap.dart';
import 'MapPageHistory.dart';
import 'SettingsOnePage.dart';
import '../my_flutter_app_icons.dart' as CustomIcon;

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>
  with SingleTickerProviderStateMixin {

  TabController _tabController;
  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    //_tabController = new TabController(length: 3, vsync: this);
    //_tabController.animateTo(1,duration: Duration(milliseconds: 500),curve: Curves.fastOutSlowIn);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    debugPrint("rebuilding");
    SystemChrome.setEnabledSystemUIOverlays([]);
    return  Card(
      margin: EdgeInsets.all(0),
      child:Stack(
        children:<Widget> [
          MainMap(currentIndex == 1),
          display(currentIndex),
          Column(mainAxisAlignment: MainAxisAlignment.end, children:<Widget>[
            Container(
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.elliptical(35,25),topRight: Radius.elliptical(35,25),),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new FlatButton(child:
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                    Icon(CustomIcon.CustomIcon.map,color: currentIndex == 0 ? Colors.blue : Colors.black,),
                  ],),
                    onPressed: () => goTo(""),
                  ),
                  new FlatButton(child:
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                    Icon(CustomIcon.CustomIcon.th_large_outline,color: currentIndex == 1 ? Colors.blue : Colors.black,),
                  ],),
                    onPressed: () => goTo("past"),
                  ),
                  new FlatButton(child:
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                    Icon(Icons.person,color: currentIndex == 2 ? Colors.blue : Colors.black,),
                  ],),
                    onPressed: () => goTo("profile"),
                  ),
                ],
              ),
            ),
          ],
          ),])
    );
  }

  Widget display(int num){
    if (num == 2) {return SettingsOnePage();}
    return Container(height: 0,color: Colors.red,);
  }

  int currentIndex = 0;

  goTo(String page){
    switch (page){
      case "past" :
        {
          setState(() {
            currentIndex = 1;
          });
//          Navigator.pushReplacement(context,
//            MaterialPageRoute(builder: (context) => MapPageHistory("route_1304")));
        }
      break;
      case "profile" :
        {
          setState(() {
            currentIndex = 2;
          });
        }
      break;
      default : {
        setState(() {
          currentIndex = 0;
        });
      }
      break;
    }
  }
}

//--------------------------------------------//
/*

Card(
      margin: EdgeInsets.all(0),
      child:Stack(
        children:<Widget> [
          TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              MainMap(),
              MapPageHistory("route_1304"),
              SettingsOnePage(),
            ],
            controller: _tabController,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children:<Widget>[Container(
            height: 65,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.elliptical(35,25),topRight: Radius.elliptical(35,25),),
            ),
            child: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.blue,
              indicatorColor: Colors.white,
              tabs: [
                new Container(child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  Icon(CustomIcon.CustomIcon.map,),
                ],),),
                new Container(child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  Icon(CustomIcon.CustomIcon.th_large_outline,),
                ],),),
                new Container(child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  Icon(Icons.person,),
                ],),),
              ],
              controller: _tabController,
            ),
          ),
          ],
          ),])
    );

*/