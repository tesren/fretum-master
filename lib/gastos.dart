import 'package:flutter/material.dart';
import 'package:fretummaster/citas.dart';
import 'colors.dart';

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
        drawer: crearDrawer(context),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            backgroundColor: azulFretum,
            child: Icon(Icons.remove),
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/agregarGasto');

            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: 70.0,
                width: double.infinity,
                color: Colors.grey[300],
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Total de gastos mensuales", style: estiloNegro,),
                    ),
                    Text("MXN\$00000.00", style: estiloAzul,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
