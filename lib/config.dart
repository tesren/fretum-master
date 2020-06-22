import 'package:flutter/material.dart';
import 'package:fretummaster/citas.dart';
import 'colors.dart';

class Config extends StatefulWidget {
  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Text("Configuración",
                style: estiloBlanco),
          ],
        ),
        backgroundColor: azulFretum,
      ),
      drawer: crearDrawer(context),
    );
  }
}
