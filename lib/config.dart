import 'package:flutter/material.dart';
import 'package:fretummaster/citas.dart';
import 'colors.dart';

class Config extends StatefulWidget {
  @override
  _ConfigState createState() => _ConfigState();

}

class _ConfigState extends State<Config> {
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
              Text("Configuración",
                  style: estiloBlanco),
            ],
          ),
          backgroundColor: azulFretum,
        ),
        drawer: crearDrawer(context),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/perfil');
                  },
                  child: Container(
                    width: double.infinity, height: 105,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5.0,0.0,8.0,0.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage("assets/profilepic.png"),
                            radius: 45.0,
                          ),
                        ),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Erick Alejandro Pérez Macedo", style: estiloNegro,),
                                Text("322-108-4847", style: estiloGris,),
                                Text("tesren@live.com.mx", style: estiloGris,),
                              ],
                            )),
                        Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 25.0,),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                child: InkWell(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/reportar');
                  },
                  child: Container(
                    width: double.infinity, height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                          child: Icon(Icons.warning, color: Colors.grey, size: 35.0,),
                        ),
                        Expanded(child: Text("Reportar un problema", style: estiloNegro,)),
                        Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20.0,),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                child: InkWell(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/terminos');
                  },
                  child: Container(
                    width: double.infinity, height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                          child: Icon(Icons.description, color: Colors.grey, size: 35.0,),
                        ),
                        Expanded(child: Text("Términos y condiciones", style: estiloNegro,)),
                        Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20.0,),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                child: Container(
                  width: double.infinity, height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        child: Icon(Icons.mail, color: Colors.grey, size: 35.0,),
                      ),
                      Expanded(child: Text("Buzón de quejas y sugerencias", style: estiloNegro,)),
                      Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20.0,),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                child: InkWell(
                  onTap: (){
                    showDialog(context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Cerrar Sesión", style: estiloNegro,),
                      content: Text("¿Estás seguro que deseas cerrar la sesión actual?", style: estiloGris,),
                      actions: <Widget>[
                        FlatButton(child: Text("Cancelar"),
                        onPressed: (){
                          Navigator.pop(context);
                          },),
                        FlatButton(child: Text("Si"),
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, '/login');
                        },)
                      ],
                      elevation: 20.0,
                      backgroundColor: Colors.grey[100],
                    ),
                    barrierDismissible: true);
                  },
                  child: Container(
                    width: double.infinity, height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                          child: Icon(Icons.exit_to_app, color: Colors.grey, size: 35.0,),
                        ),
                        Expanded(child: Text("Cerrar sesión", style: estiloNegro,)),
                        //Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20.0,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
