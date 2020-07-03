import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fretummaster/colors.dart';

class Citas extends StatefulWidget {
  @override
  _CitasState createState() => _CitasState();
}

class _CitasState extends State<Citas> {
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
        drawer: crearDrawer( context ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10,10,10,0),
          height: 140,
          width: double.maxFinite,
          child: Card(
            elevation: 5,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.calendar_today, color: Colors.black),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Align(alignment: Alignment.centerLeft,
                          child: Container(child: Text("30-Junio-2020, 8:00 am", style: estiloNegro,))),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on, color: Colors.grey),
                    Text("Francisco I. Madero 467, Emiliano Zapata, 48380", style: estiloGris,)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.timer, color: Colors.grey),
                    Text("De 60 a 90 mins", style: estiloGris),
                  ],
                ),
                Text("Total", style: estiloAzul,),
                Text("MXN\$300"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Widget crearDrawer(BuildContext context){
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,0.0,8.0,0.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/profilepic.png"),
                  radius: 55.0,
                ),
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Erick Alejandro Pérez Macedo", style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5.0),
                      Text("322-108-4847", style: TextStyle(color: Colors.white, fontSize: 14.0)),
                      Text("tesren@live.com.mx", style: TextStyle(color: Colors.white, fontSize: 14.0)),
                    ],
                  )),
              //Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 25.0,),
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
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20.0),
          onTap: (){
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/citas');
          },
        ),
        ListTile(
          title: Text("Perfil",
              style: estiloNegro),
          leading: Icon(Icons.account_circle, color: Colors.black,),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20.0),
          onTap: (){
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/perfil');

          },
        ),
        ListTile(
          title: Text("Ingresos",
              style: estiloNegro),
          leading: Icon(Icons.attach_money, color: Colors.black),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20.0),
          onTap: (){
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/ingresos');
          },
        ),
        ListTile(
          title: Text("Gastos",
              style: estiloNegro),
          leading: Icon(Icons.money_off, color: Colors.black),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20.0),
          onTap: (){
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/gastos');
          },
        ),
        ListTile(
          title: Text("Configuración",
              style: estiloNegro),
          leading: Icon(Icons.settings, color: Colors.black),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20.0),
          onTap: (){
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/config');
          },
        ),
      ],
    ),
  );
}
