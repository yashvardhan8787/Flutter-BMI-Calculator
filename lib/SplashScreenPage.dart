import 'dart:async';

import 'package:bmi_calculator/MyHomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();


  }

class _SplashScreenPageState extends State<SplashScreenPage> {

  void initState (){
  super.initState();
  Timer( Duration(seconds: 5),() {
    Navigator.pushReplacement(context,MaterialPageRoute(
        builder: (BuildContext context) => MyHomePage(title: "my home page "))
    );
  },
    );


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: Center(
        child:Container(
          decoration: BoxDecoration( color:CupertinoColors.systemGrey6),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo.webp"),radius: 200,
            ),
            const Text(
              "Get Your BMI",style: TextStyle(color: Colors.black,fontSize:34,fontWeight:FontWeight.w900  ),
            ),

          ],
        ),
      ),
    ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
