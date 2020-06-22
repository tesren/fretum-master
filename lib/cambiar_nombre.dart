import 'package:flutter/material.dart';
import 'colors.dart';

class CambiarNombre extends StatefulWidget {
  @override
  _CambiarNombreState createState() => _CambiarNombreState();
}

class _CambiarNombreState extends State<CambiarNombre> {
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
            Text("Cambia tu nombre",
                style: estiloBlanco),
          ],
        ),
        backgroundColor: azulFretum,
      ),

    );
  }
}
