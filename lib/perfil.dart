import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fretummaster/drawer.dart';
import 'colors.dart';
import 'perfil/perfil_datos.dart';
import 'package:fretummaster/services/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

  var txt = TextEditingController();
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {


        return WillPopScope(
          onWillPop: () async {
            if (_key.currentState.isDrawerOpen) {
              Navigator.of(context).pop();
              return false;
            }
            else{
              _key.currentState.openDrawer();
            }
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
                  Text("Perfil",
                      style: estiloBlanco),
                ],
              ),
              backgroundColor: azulFretum,
            ),
            drawer: NavigationDrawer(),
            body:  DatosPerfil() ?? Container(
              child: Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Cargando datos..', style: estiloGris,),
                    SizedBox(height: 20),
                    SpinKitFadingCube(
                      color: azulFretum,
                      size: 40,
                    )
                  ],
                ),),
            ) ,
          ),
        );
  }
}
