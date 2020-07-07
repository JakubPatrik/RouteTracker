import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Authentication/LogInScreen.dart';

import 'dart:async';

import '../HomePage/HomeScreen.dart';
import '../MyClipper.dart';
import '../Animation/FadeAnimation.dart';
import '../SharedPref.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen>{

  List myData;

  TextEditingController usernameCntrl = TextEditingController();
  TextEditingController lastnameCntrl = TextEditingController();
  TextEditingController emailCntrl = TextEditingController();
  TextEditingController passwordCntrl = TextEditingController();

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
                      padding: EdgeInsets.only(top: 45.0, bottom: 45.0,left:170),
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
                      Text("Sign Up",
                        style: TextStyle(color: Colors.black, fontSize: 28.0,fontFamily: 'Corbel',fontWeight: FontWeight.bold),
                      ),
                      Container(color:Colors.red,width:80,height: 2,),
                    ],)
                  ),),
                  FadeAnimation(0.5,Container(
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
                            controller: usernameCntrl,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your username',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
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
                            controller: emailCntrl,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your email address',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),),
                  FadeAnimation(1,Container(
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
                            controller: passwordCntrl,
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
                  FadeAnimation(1.2,Container(
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
                                "SIGN UP",
                                style: TextStyle(color: Colors.white,fontSize: 18),
                              ),
                            ),
                            onPressed: () => pushData(),
                          ),
                        ),
                      ],
                    ),
                  ),),
                  FadeAnimation(1.5,Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(height:70,
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
                                  Text("Already have an acount? ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text("LOG IN",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],)
                            ),
                            onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => LoginScreen())),
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

//--------------------------<FUNCTIONS>----------------------------//

bool flag = false;

  Future navigateHome() async {
    await pushData();
    if(flag)
    await Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  SharedPref _sharedPref = SharedPref();

  Future pushData() async{
    String fname = usernameCntrl.text.toString();
    String email = emailCntrl.text.toString();
    String password = passwordCntrl.text.toString();
    _sharedPref.save("id_pass",fname+"_"+password);
    if(fname.isNotEmpty && email.contains("@") && password.isNotEmpty){
      flag = true;
      String url = "https://users-database.000webhostapp.com/add.php?fname=$fname&email=$email&pass=$password";
      await http.get(url);
    }
    else{debugPrint("wrong format!");}
  }

  @override
  void initState() {
    super.initState();
    pushData();
  }
}
