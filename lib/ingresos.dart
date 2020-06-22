import 'package:flutter/material.dart';
import 'colors.dart';
import 'citas.dart';

class Ingresos extends StatefulWidget {
  @override
  _IngresosState createState() => _IngresosState();
}

class _IngresosState extends State<Ingresos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: azulFretum,
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
            Text("Ingresos",
                style: estiloBlanco),
          ],
        ),
      ),
      drawer: crearDrawer(context),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          backgroundColor: azulFretum,
          child: Icon(Icons.add),
            onPressed: (){
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
                    child: Text("Total de ingresos mensuales", style: estiloNegro,),
                  ),
                  Text("MXN\$00000.00", style: estiloAzul,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
