import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fretummaster/colors.dart';
import 'package:fretummaster/services/user_model.dart';
import 'package:fretummaster/services/user.dart';
import 'package:fretummaster/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context) ;


    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;

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
                          backgroundImage: AssetImage("assets/baseline_account_circle_black_48dp.png"),
                          radius: 55.0,
                        ),
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("${userData.nombre} ${userData.apellidos}", style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)),
                              SizedBox(height: 5.0),
                              Text("${userData.telefono.toString()}", style: TextStyle(color: Colors.white, fontSize: 14.0)),
                              Text("${userData.correo}", style: TextStyle(color: Colors.white, fontSize: 14.0)),
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
               /* ListTile(
                  title: Text("Ingresos",
                      style: estiloNegro),
                  leading: Icon(Icons.attach_money, color: Colors.black),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20.0),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/ingresos');
                  },
                ),*/
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
        } else{
          return Container(
            child: Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Cargando datos..', style: estiloGris,),
                  SizedBox(height: 25),
                  SpinKitFadingCube(
                    color: azulFretum,
                    size: 40,
                  )
                ],
              ),
            ),
          );
        }

      }
    );
  }
}
