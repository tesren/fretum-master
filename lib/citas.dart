import 'package:flutter/material.dart';
import 'package:fretummaster/colors.dart';

class Citas extends StatefulWidget {
  @override
  _CitasState createState() => _CitasState();
}

class _CitasState extends State<Citas> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Citas",
        style: estiloBlanco),
        backgroundColor: azulFretum,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      child: Image(
                        image: AssetImage("assets/ic_launcher_round.png")),
                      backgroundColor: Colors.white,
                      radius: 50.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text("Nombre de usuario",
                      style: estiloBlanco),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text("5.0",
                    style: estiloBlanco),
                  ),
                  Align(
                    alignment: Alignment.center + Alignment( 0.25, 0.0),
                    child: Icon(Icons.star, color: Colors.white),
                  )
                ],
              ),
              decoration: BoxDecoration(
               gradient: LinearGradient(
                 colors: <Color>[
                   azulFretum,
                   Colors.blue[800]
                 ]
               )
              ),
            ),
            ListTile(
              title: Text("Citas",
              style: estiloNegro),
              leading: Icon(Icons.calendar_today, color: Colors.black),
              onTap: (){

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Perfil",
              style: estiloNegro),
              leading: Icon(Icons.account_circle, color: Colors.black,),
              onTap: (){


                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Ingresos",
              style: estiloNegro),
              leading: Icon(Icons.attach_money, color: Colors.black),
              onTap: (){

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Gastos",
                  style: estiloNegro),
              leading: Icon(Icons.money_off, color: Colors.black),
              onTap: (){

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Configuración",
                  style: estiloNegro),
              leading: Icon(Icons.settings, color: Colors.black),
              onTap: (){

                Navigator.pop(context);
              },
            ),
            ],
        ),
      ),
    );
  }
}
