import 'package:flutter/material.dart';
import 'package:fretummaster/services/user_model.dart';
import '../colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fretummaster/services/user.dart';
import 'package:provider/provider.dart';
import 'package:fretummaster/services/database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CambiarNombre extends StatefulWidget {
  @override
  _CambiarNombreState createState() => _CambiarNombreState();
}

class _CambiarNombreState extends State<CambiarNombre> {
  Color _colorCubo = Colors.transparent;
  String _currentName;
  final _formKey = GlobalKey<FormState>();

  FToast fToast;

  Widget _toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.green,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle, color: Colors.white),
        SizedBox(
          width: 12.0,
        ),
        Text("Nombre cambiado", style: TextStyle(fontSize: 14, color: Colors.white),),
      ],
    ),
  );

  _showToast() {
    fToast.showToast(
      child: _toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }


  @override
  Widget build(BuildContext context) {

    fToast = FToast(context);
    User user = Provider.of<User>(context);

    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacementNamed(context, '/perfil');
        return false;
      },
      child: StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            return Scaffold(
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
                    Text("Cambiar nombre",
                        style: estiloBlanco),
                  ],
                ),
                backgroundColor: azulFretum,
                automaticallyImplyLeading: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pushReplacementNamed(context, '/perfil'),
                ),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          initialValue: userData.nombre,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            labelText: "Nombre",
                          ),
                          validator: (val) => val.isEmpty ? 'Por favor ingrese un nombre' : null,
                          onChanged: (val) => setState(() => _currentName = val),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          width: double.infinity,
                          height: 55.0,
                          child: RaisedButton(
                            color: azulFretum,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Text("Guardar cambios", style:  estiloBlanco,),
                            onPressed: () async{
                              if(_formKey.currentState.validate()){
                                setState(() {
                                  _colorCubo = azulFretum;
                                });
                                await DatabaseService(uid: user.uid).updateUserData(
                                    _currentName ?? snapshot.data.nombre,
                                  snapshot.data.apellidos,
                                  snapshot.data.telefono,
                                  snapshot.data.correo,
                                );
                                _showToast();
                                Navigator.pushReplacementNamed(context, '/perfil');
                              }

                            },
                          ),
                        ),
                        SizedBox(height: 25),
                        SpinKitFadingCube(
                          size: 40.0,
                          color: _colorCubo,
                        ),
                      ],
                    )
                  ),
                ),
              ),

            );
          }else{
            return Scaffold(
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
                    Text("Cambiar nombre",
                        style: estiloBlanco),
                  ],
                ),
                backgroundColor: azulFretum,
                automaticallyImplyLeading: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pushReplacementNamed(context, '/perfil'),
                ),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0.0),
                  child: Column(
                    children: <Widget>[
                      Text("Cargando...", style: estiloGris),
                      SizedBox(height: 35.0),
                      SpinKitFadingCube(
                        size: 40.0,
                        color: azulFretum,
                      ),
                    ],
                  ),
                ),
              ),

            );
          }

        }
      ),
    );
  }
}
