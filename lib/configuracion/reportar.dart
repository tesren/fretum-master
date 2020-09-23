import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Reportar extends StatefulWidget {
  @override
  _ReportarState createState() => _ReportarState();
}

class _ReportarState extends State<Reportar> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  Color _colorCubo = Colors.transparent;
  final db = Firestore.instance;
  String problema = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
      Navigator.pushReplacementNamed(context, '/config');
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
                    onChanged: (val){
                      setState(() {
                        problema = val;
                      });
                    },
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

                      //registrar problema
                      onPressed: ()async {
                        if (problema == "" || problema.length < 8) {
                          _key.currentState.showSnackBar(SnackBar(content: Text(
                              "Por favor describe mas el problema")));
                        }
                        else {
                          setState(() {
                            _colorCubo = azulFretum;
                          });

                          DocumentReference ref = await db.collection(
                              "problemas").add({
                            'problema': '$problema',
                          });

                          Fluttertoast.showToast(
                              msg: "Problema reportado",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          Navigator.pushReplacementNamed(context, '/config');
                        }
                      }
                    ),
                  ),
                  SizedBox(height: 30),
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
