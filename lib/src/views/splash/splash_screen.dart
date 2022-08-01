import 'dart:async';
import 'package:flutter/material.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Golo/src/views/main/dashboard_tabs.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      openDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Container(
              height: 275,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image(
                      image: AssetImage('assets/app/launch/golo-logo.png'),
                      fit: BoxFit.cover),
                  Column(
                    children: <Widget>[
                      Text(
                        "Golo",
                        style: TextStyle(
                            fontFamily: GoloFont,
                            fontSize: 50,
                            fontWeight: FontWeight.w500,
                            color: GoloColors.secondary1),
                      ),
                      Text(
                        "Travel city guide template",
                        style: TextStyle(
                            fontFamily: GoloFont,
                            fontSize: 22,
                            color: GoloColors.secondary1),
                      )
                    ],
                  ),
                  Container(
                    height: 50,
                    child: SpinKitChasingDots(
                      color: GoloColors.primary,
                      size: 45,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                child: Column(
                  children: <Widget>[
                    Text(
                      "V.1.1.0",
                      style: TextStyle(
                          fontFamily: GoloFont,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: GoloColors.secondary1),
                    ),
                    Text(
                      "2021 © uxper.co",
                      style: TextStyle(
                          fontFamily: GoloFont,
                          fontSize: 15,
                          color: GoloColors.secondary2),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  // ### Navigation
  void openDashboard() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => DashboardTabs()));
  }
}
