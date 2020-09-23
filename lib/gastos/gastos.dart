import 'package:flutter/material.dart';
import 'package:fretummaster/drawer.dart';
import 'package:fretummaster/gastos/gastos_lista.dart';
import 'package:fretummaster/gastos/gastos_model.dart';
import 'package:fretummaster/services/database.dart';
import 'package:provider/provider.dart';
import '../colors.dart';

class Gastos extends StatefulWidget {
  @override
  _GastosState createState() => _GastosState();
}

class _GastosState extends State<Gastos> {

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
      child: StreamProvider<List<GastosModel>>.value(
        value: DatabaseService().gastos,
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
                Text("Gastos",
                    style: estiloBlanco),
              ],
            ),
            backgroundColor: azulFretum,
          ),
          drawer: NavigationDrawer(),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              backgroundColor: azulFretum,
              child: Icon(Icons.add),
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/agregarGasto');
              },
            ),
          ),
          body: GastosLista(),
        ),
      ),
    );
  }
}
