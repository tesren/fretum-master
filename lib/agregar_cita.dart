import 'package:flutter/material.dart';
import 'colors.dart';

class Agregar_cita extends StatefulWidget {
  @override
  _Agregar_citaState createState() => _Agregar_citaState();
}

class _Agregar_citaState extends State<Agregar_cita> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/citas');
        return false;
      },
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,0.0,5.0,0.0),
                child: Image(
                  image: AssetImage("assets/ic_launcher_round.png"),
                  fit: BoxFit.contain,
                  height: 32,
                ),
              ),
              Text("Agregar una cita",
                  style: estiloBlanco),
            ],
          ),
          backgroundColor: azulFretum,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pushReplacementNamed(context, '/citas'),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

              ],
            ),
          ),
        ),

      ),
    );
  }
}
