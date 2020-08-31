import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fretummaster/colors.dart';
import 'package:fretummaster/drawer.dart';
import 'package:fretummaster/services/database.dart';
import 'package:provider/provider.dart';
import 'citas_model.dart';
import 'citas_lista.dart';


class CitasMostrar extends StatefulWidget {
  @override
  _CitasMostrarState createState() => _CitasMostrarState();
}

class _CitasMostrarState extends State<CitasMostrar> {

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
      child: StreamProvider<List<CitasModel>>.value(
        value: DatabaseService().citas,
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
                Text("Citas",
                style: estiloBlanco),
              ],
            ),
            backgroundColor: azulFretum,
          ),

          floatingActionButton: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              backgroundColor: azulFretum,
              child: Row(
                children: <Widget>[
                  Icon(Icons.add, color: Colors.white, size: 17,),
                  Icon(Icons.calendar_today),
                ],
              ),
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/agregar_cita');

              },
            ),
          ),

          drawer: NavigationDrawer(),

          body: CitasLista()
        ),
      ),
    );
  }
}


