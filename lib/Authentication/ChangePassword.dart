import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Authentication/PasswordReset.dart';
import 'package:myapp/HomePage/SettingsOnePage.dart';

import 'dart:async';

import '../Animation/FadeAnimation.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword>{

  List myData;

  TextEditingController oldPasswordCntrl = TextEditingController();
  TextEditingController newPasswordCntrl = TextEditingController();
  TextEditingController newPasswordCntrl2 = TextEditingController();

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
              Row(
                children: <Widget>[
                  FadeAnimation(0.35,Padding(
                    padding: const EdgeInsets.only(left: 20.0,top:60,bottom:15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FlatButton(padding: EdgeInsets.only(right:80), child: Icon(Icons.arrow_back),onPressed: ()=> Navigator.pop(context),),
                        SizedBox(height: 20,),
                        Text("Reset Password",
                          style: TextStyle(color: Colors.black, fontSize: 28.0,fontFamily: 'Corbel',fontWeight: FontWeight.bold),
                        ),
                        Container(color:Colors.red,width:180,height: 2,),
                      ],)
                  ),),
                  SizedBox(width:35),
                  FadeAnimation(0.2,Padding(
                    padding: EdgeInsets.only(top:30),
                    child:Container(
                      alignment: Alignment.topRight,
                      child: Image.asset("assets/password.png",scale:0.5,height: 150,),
                    ),
                  ),),
              ],),

              FadeAnimation(0.6,Padding(
                padding: const EdgeInsets.only(left: 20.0,top:30),
                child: Column(children: <Widget>[
                  Text("Current Password",
                    style: TextStyle(color: Colors.grey, fontSize: 18.0,fontFamily: 'Corbel'),
                  ),
                ],)
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
                        controller: oldPasswordCntrl,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '********',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ),),
              FadeAnimation(0.6,Padding(
                padding: const EdgeInsets.only(left: 20.0,top:10),
                child: Column(children: <Widget>[
                  Text("New Password",
                    style: TextStyle(color: Colors.grey, fontSize: 18.0,fontFamily: 'Corbel'),
                  ),
                ],)
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
                        controller: newPasswordCntrl,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '********',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ),),
              FadeAnimation(0.6,Padding(
                padding: const EdgeInsets.only(left: 20.0,top:10),
                child: Column(children: <Widget>[
                  Text("Confirm New Password",
                    style: TextStyle(color: Colors.grey, fontSize: 18.0,fontFamily: 'Corbel'),
                  ),
                ],)
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
                        controller: newPasswordCntrl2,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '********',
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
                            "RESET PASSWORD",
                            style: TextStyle(color: Colors.white,fontSize: 18),
                          ),
                        ),
                        onPressed: () => pushData(),
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
  Map info;

  Future pushData() async{
    String username = await SettingsOnePage().getName();
    String oldXPass = await SettingsOnePage().getPass();
debugPrint(username + ", " + oldXPass);

    String oldPass =  oldPasswordCntrl.text.toString();
    String newPass = newPasswordCntrl.text.toString();
    String newPass2 = newPasswordCntrl2.text.toString();

    if(oldXPass == oldPass && newPass.length>8 && newPass == newPass2){
      String url = "https://users-database.000webhostapp.com/reset.php?username=$username&old=$oldPass&new=$newPass";
      await http.get(url);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> PasswordReset()));
    }
    else {
      String errorMessage;
      if (newPass != newPass2 && newPass.length<8 || newPass.length>14) {errorMessage = "Length of the password should be between 8 and 14";}
      if (newPass == oldPass) {errorMessage = "New and old password should not equal";}
      if (oldPass != oldXPass) {errorMessage = "Incorrect password";}

      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

}
