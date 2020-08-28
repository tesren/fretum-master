import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fretummaster/services/user.dart';
import 'package:provider/provider.dart';
import 'package:fretummaster/services/database.dart';
import 'package:fretummaster/services/user_model.dart';

class CambiarApellidos extends StatefulWidget {
  @override
  _CambiarApellidosState createState() => _CambiarApellidosState();
}

class _CambiarApellidosState extends State<CambiarApellidos> {
  Color _colorCubo = Colors.transparent;
  String _currentApellido;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return WillPopScope(
      onWillPop: ()async{
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
                Text("Cambiar apellidos",
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
                      initialValue: userData.apellidos,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.font_download),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: "Apellidos",
                      ),
                      validator: (val) => val.isEmpty ? 'Por favor ingrese sus apellidos' : null,
                      onChanged: (val) => setState(() => _currentApellido = val),
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
                        onPressed: () async {
                          setState(() {
                            _colorCubo = azulFretum;
                          });
                          if(_formKey.currentState.validate()){
                            await DatabaseService(uid: user.uid).updateUserData(
                              snapshot.data.nombre,
                              _currentApellido ?? snapshot.data.apellidos,
                              snapshot.data.telefono,
                              snapshot.data.correo,
                            );
                            Navigator.pushReplacementNamed(context, '/perfil');
                          }
                        },
                      ),
                    ),
                    SpinKitFadingCube(
                      size: 40.0,
                      color: _colorCubo,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        } else{
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
                  Text("Cambiar apellidos",
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
