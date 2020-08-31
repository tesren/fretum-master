import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../colors.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  void cargandoTodo() async {
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/login');
    });

  }

  @override
  void initState() {
    super.initState();
    cargandoTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: azulFretum,
        body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Image(image: AssetImage("assets/ic_launcher_round.png"),
                  fit: BoxFit.contain,
                  height: 70.0,),
                SizedBox(height: 20),
                SpinKitThreeBounce(
                  color: Colors.white,
                  size: 30.0,
                )
              ],
            )
        )
    );
  }
}