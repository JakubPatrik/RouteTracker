import 'dart:convert';

import 'package:flutter/cupertino.dart';
/// Author: Damodar Lohani

/// profile: https://github.com/lohanidamodar


import 'package:flutter/material.dart';
import 'package:myapp/Authentication/LogInScreen.dart';
import 'file:///C:/Users/Jakub%20Patrik/Android_Apps/myapp/lib/Authentication/ChangePassword.dart';
import 'package:myapp/MyClipper.dart';
import 'package:myapp/SharedPref.dart';

class SettingsOnePage extends StatefulWidget {

  @override
  _SettingsOnePageState createState() => _SettingsOnePageState();
  getName() => _SettingsOnePageState().getName();
  getPass() => _SettingsOnePageState().getPass();
}

class _SettingsOnePageState extends State<SettingsOnePage> {

  SharedPref sharedPref = new SharedPref();
  String name,pass;

  @override
  void initState() {
    getName();
    super.initState();
  }

  getName() async {
    name  = await sharedPref.read("first_name");
    name = jsonDecode(name);
    return name;
  }
  getPass() async {
    pass  = await sharedPref.read("password");
    pass = jsonDecode(pass);
    return pass;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: AssetImage("assets/sitting_man_nobox.png",),
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.topRight,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: 45.0, bottom: 45.0,left:15),
                      child:Text(
                          "settings.",
                          style: TextStyle(
                            fontSize: 62.0,
                            fontFamily: 'Corbel',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                            color: Color(0xff008080)),
                        ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 16.0),
                    elevation: 15.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.teal.withOpacity(0.7),
                    child: Container(
                      child:FutureBuilder(
                        future: getName(),
                        builder: (context,snapshot){
                        return snapshot.data==null
                        ? Center(child:CircularProgressIndicator(backgroundColor: Colors.tealAccent,))
                        : Container(
                          padding: EdgeInsets.all(10),
                            child: Text("Welcome back, " + snapshot.data,
                              style: TextStyle(
                                fontSize: 36,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      )
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Card(
                    color: Colors.white,
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.lock_outline,color: Colors.teal,),
                          title: Text("Change Password"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword())),
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.language,color: Colors.teal,),
                          title: Text("Change Language"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {},
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.location_on,color: Colors.teal,),
                          title: Text("Change Location"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:15),
                  Container(width:MediaQuery.of(context).size.width,child:Text("Developed by Jakub Patrik",textAlign: TextAlign.center,)),
                  Container(width:MediaQuery.of(context).size.width,child:Text("version 1.0.0",textAlign: TextAlign.center,)),
                  Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          width:MediaQuery.of(context).size.width*0.8,height:50,
                          child: FlatButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                            splashColor: Colors.red,
                            color: Color(0xff008080).withOpacity(0.75),
                            child: new Center(
                              child: Text(
                                "SIGN OUT",
                                style: TextStyle(color: Colors.white,fontSize: 18),
                              ),
                            ),
                            onPressed: ()=> logOut(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,)
                  ],
              ),
            ),
          ],
        ),
    );
  }

  void logOut(){
    SharedPref sharedPref = SharedPref();
    sharedPref.save("id_pass","");
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}