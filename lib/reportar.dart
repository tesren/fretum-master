import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Reportar extends StatefulWidget {
  @override
  _ReportarState createState() => _ReportarState();
}

class _ReportarState extends State<Reportar> {
  Color _colorCubo = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
      Navigator.pushReplacementNamed(context, '/config');
      return false;
    },

        child: Scaffold(
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
                Text("Reportar un problema",
                    style: estiloBlanco),
              ],
            ),
            backgroundColor: azulFretum,
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pushReplacementNamed(context, '/config'),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 15.0),
              child: Column(
                children: <Widget>[
                  Text("Por favor describe detalladamente el problema", style: estiloGris,),
                  SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.warning),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: "Describe el problema",
                    ),
                    maxLines: null,
                    maxLength: 500,
                  ),
                  SizedBox(height: 10),
                  Text("Nos comunicaremos contigo a tu correo o número de teléfono para dar respuesta a tu problema", style: estiloGris, textAlign: TextAlign.center),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity, height: 55,
                    child: RaisedButton(
                      elevation: 4.0,
                      color: azulFretum,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Text("Enviar", style:  estiloBlanco,),
                      onPressed: (){
                        setState(() {
                          _colorCubo = azulFretum;
                        });
                        Navigator.pushReplacementNamed(context, '/config');
                      },
                    ),
                  ),
                  SpinKitFadingCube(
                    size: 40.0,
                    color: _colorCubo,
                  ),
                ],
              ),
            ),
          ),
    ),
    );
  }
}
