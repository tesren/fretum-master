import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:fretummaster/services/database.dart';
import 'package:fretummaster/services/user.dart';
import 'package:provider/provider.dart';
import 'package:fretummaster/services/user_model.dart';

class CambiarTelefono extends StatefulWidget {
  @override
  _CambiarTelefonoState createState() => _CambiarTelefonoState();
}

class _CambiarTelefonoState extends State<CambiarTelefono> {

  Color _colorCubo = Colors.transparent;
  final _cPhone = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
        Text("Telefono cambiado", style: TextStyle(fontSize: 14, color: Colors.white),),
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
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                      child: Image(
                        image: AssetImage("assets/ic_launcher_round.png"),
                        fit: BoxFit.contain,
                        height: 32,
                      ),
                    ),
                    Text("Cambiar teléfono",
                        style: estiloBlanco),
                  ],
                ),
                backgroundColor: azulFretum,
                automaticallyImplyLeading: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/perfil'),
                ),
              ),

              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 25.0),
                  child: Column(
                    children: <Widget>[

                      //telefono a cambiar
                      InternationalPhoneNumberInput(
                        ignoreBlank: false,
                        maxLength: 15,
                        countries: ['MX'],
                        autoValidate: false,
                        selectorTextStyle: TextStyle(color: Colors.black),
                        textFieldController: _cPhone,
                        inputDecoration: InputDecoration(
                          prefixIcon: Icon(
                              Icons.local_phone, color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Nuevo teléfono",
                        ),
                      ),
                      SizedBox(height: 15.0),

                      //boton para cambiar telefono
                      Container(
                        width: double.infinity, height: 55,
                        child: RaisedButton(
                          elevation: 4.0,
                          color: azulFretum,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Text("Guardar cambios", style: estiloBlanco,),

                          onPressed: () async {
                            if (_cPhone.text.isEmpty|| _cPhone.text.length < 10) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Por favor introduce un número válido")));
                            } else {
                              setState(() {
                                _colorCubo = azulFretum;
                              });
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(
                                snapshot.data.nombre,
                                snapshot.data.apellidos,
                                _cPhone.text.toString() ?? snapshot.data.telefono,
                                snapshot.data.correo,
                              );
                              _showToast();
                              Navigator.pushReplacementNamed(context, '/perfil');
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 25,),
                      SpinKitFadingCube(
                        size: 40.0,
                        color: _colorCubo,
                      ),
                    ],
                  ),
                ),
              ),
            );

            //widget de cargando
          } else {
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
        }),
    );
  }
}
