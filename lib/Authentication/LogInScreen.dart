import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import '../User.dart';
import '../HomePage/HomeScreen.dart';
import 'SignUpScreen.dart';
import '../SharedPref.dart';
import '../MyClipper.dart';
import '../Animation/FadeAnimation.dart';
//--------------TRY GOING STATELESS----------------------//
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen>{

  User currentUser;
  Map info;
  SharedPref sharedPref = SharedPref();

  TextEditingController usernameCntrl = TextEditingController();
  TextEditingController passwordCntrl = TextEditingController();

  @override
  void initState(){
    super.initState();
    sharedPref.remove("id_pass");
    debugPrint("removing id_pass");
  }

  @override
  void dispose() {
    usernameCntrl.dispose();
    passwordCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
            body: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          FadeAnimation(0.2,ClipPath(
            clipper: MyClipper(),
            child: Container(
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: AssetImage("assets/doctor.png",),
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.topLeft,
                ),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 45.0, bottom: 45.0,left:170.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "see it.",
                    style: TextStyle(
                        fontSize: 92.0,
                        fontFamily: 'Corbel',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        color: Color(0xff008080)),
                  ),
                  Text(
                    "see where you've been",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Corbel',
                        fontWeight: FontWeight.bold,
                        color: Color(0xff008080)),
                  ),
                ],
              ),
            ),
          ),),
          FadeAnimation(0.35,Padding(
            padding: const EdgeInsets.only(left: 40.0,top:0,bottom:15),
            child: Column(children: <Widget>[
              Text("Log In",
                style: TextStyle(color: Colors.black, fontSize: 28.0,fontFamily: 'Corbel',fontWeight: FontWeight.bold),
              ),
              Container(color:Colors.red,width:80,height: 2,),
            ],)
          ),),
          FadeAnimation(0.5,Padding(
            padding: const EdgeInsets.only(left: 40.0,top:10),
            child: Text(
              "Name",
              style: TextStyle(color: Colors.grey, fontSize: 16.0,),
            ),
          ),),
          FadeAnimation(0.8,Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff008080).withOpacity(0.5),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              children: <Widget>[
                new Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Icon(Icons.person_outline,color: Colors.grey,),
                ),
                Container(
                  height: 30.0,
                  width: 1.0,
                  color:  Color(0xff008080).withOpacity(0.5),
                  margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                ),
                new Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: usernameCntrl,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your username',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),),
          FadeAnimation(1,Padding(
            padding: const EdgeInsets.only(left: 40.0,top:5),
            child: Text(
              "Password",
              style: TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
          ),),
          FadeAnimation(1.2,Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff008080).withOpacity(0.5),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              children: <Widget>[
                new Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Icon(
                    Icons.lock_open,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 30.0,
                  width: 1.0,
                  color: Color(0xff008080).withOpacity(0.5),
                  margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                ),
                new Expanded(
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordCntrl,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          ),),
          FadeAnimation(1.5,Container(
            margin: const EdgeInsets.only(top: 35.0),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width:350,height:50,
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    splashColor: Colors.red,
                    color: Color(0xff008080).withOpacity(0.75),
                    child: new Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white,fontSize: 18),
                      ),
                    ),
                    onPressed: () => logIn(),
                  ),
                ),
              ],
            ),
          ),),
          FadeAnimation(1.8,Container(
            margin: const EdgeInsets.only(top: 10.0),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20.0),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Text("Don't have an acount? ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text("SIGN UP",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],)
                    ),
                    onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => SignUpScreen())),
                  ),
                ),
              ],
            ),
          ),),
        ],
      ),
    )
    ));
  }



//-------------<FUNCTIONS>----------------------------------------------------------------//

  SharedPref _sharedPref = SharedPref();
  String username,password;

  Future logIn() async {
    username = usernameCntrl.text.toString();
    password = passwordCntrl.text.toString();
    _sharedPref.save("id_pass","logged");
    debugPrint("logged in");
    var url = "https://users-database.000webhostapp.com/verify.php?username=$username&password=$password";
    http.Response response = await http.get(url);
    if(response.body == "User verified"){
      await getData();
      //currentUser = User(info["first_name"],info["last_name"],info["email"],info["password"]);
      sharedPref.save("first_name", info["first_name"]);
      sharedPref.save("last_name", info["last_name"]);
      sharedPref.save("email", info["email"]);
      sharedPref.save("password", info["password"]);

      await Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  Future getData() async{
    var url = 'https://users-database.000webhostapp.com/get.php?username=$username&password=$password';
    http.Response response = await http.get(url);
    info = jsonDecode(response.body);
  }

}
