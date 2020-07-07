import 'package:flutter/material.dart';
import 'package:myapp/Animation/FadeAnimation.dart';

import '../Authentication/LogInScreen.dart';
import '../Authentication/SignUpScreen.dart';

class SlideThree extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: sh,
        decoration: BoxDecoration(
        color: Colors.white,
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          FadeAnimation(0.2,Padding(
          padding: EdgeInsets.only(top:30),
          child:Container(
            alignment: Alignment.topCenter,
            height: sh*0.5,
            child: Image.asset("assets/welcome_map.png",scale:1.2,width:sw*1.2,height: sh,),
            ),
          ),
        ),
        FadeAnimation(1.5,Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
          shape: BoxShape.circle,
          ),
          child: Column(children:<Widget>[
            SizedBox(height: 60,),
            Padding(
            padding: EdgeInsets.only(left:50,right:50),
            child:Text("Rate your route for a personalized experience",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20,fontFamily: 'Corbel'),),
            ),
            SizedBox(height:50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                Container(
                  width:sw*0.3,
                  decoration: BoxDecoration(
                    color: Color(0xff008080),
                    boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 15.0,offset: Offset.zero,spreadRadius: 4.0)],
                  ),
                  child: FlatButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder:(context) => LoginScreen())),
                    child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 16),),)
                ),
                SizedBox(width:20),
                Container(
                  width:sw*0.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 15.0,offset: Offset.zero,spreadRadius: 2.0)],
                  ),
                  child: FlatButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder:(context) => SignUpScreen())),
                    child: Text("Sign Up",style: TextStyle(fontSize: 16),)),
                ),
              ]
            )
          ])
        )
      )]
    ))
    );
  }
}

//-------------------------------------//
/*


 */