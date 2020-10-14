import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fretummaster/colors.dart';
import 'package:fretummaster/main.dart';
import 'package:fretummaster/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences localStorage;
  Map data = {};
  bool checkBoxValue = true;
  Color _colorCubo = Colors.transparent;
  final AuthService _auth = AuthService();
  final cContra = TextEditingController();
  final cEmail = TextEditingController();

  FToast fToast;
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: azulFretum,
    ),
    child: Text("Bienvenido a Fretum Master", style: TextStyle(fontSize: 14, color: Colors.white),),
  );
  _showToast() {
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }


  @override
  void initState(){
    super.initState();
    _getLocalStorage();
  }

  Future _getLocalStorage() async{
    localStorage = await SharedPreferences.getInstance();
    final shCorreo = localStorage.getString('correo');
    final shContra = localStorage.getString('contra');
    cEmail.text = shCorreo;
    cContra.text = shContra;
  }

  save() async{
    await _LoginState()._getLocalStorage();
    localStorage.setString('correo', cEmail.text.toString());
    localStorage.setString('contra', cContra.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    fToast = FToast(context);
    // set background image
   // String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    //Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: null,
        backgroundColor: azulFretum,
        centerTitle: true,
        title: Text("Fretum master",
        style: estiloBlanco,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Image(image: AssetImage("assets/ic_launcher_round.png"),
                  fit: BoxFit.contain,
                  height: 75.0,
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(40.0,5.0,40.0,3.0),
                    child: Image(image: AssetImage("assets/titulo.png"))),
                Container(
                  margin: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 30.0),
                  child: Column(
                    children: <Widget>[

                      //email
                      TextField(
                        controller: cEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Colors.grey),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          labelText: "Correo electrónico"
                        ),
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                      ),
                      SizedBox(height: 15.0),

                      //contraseña
                      TextFormField(
                        controller: cContra,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Colors.grey),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          labelText: "Contraseña",
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: checkBoxValue,
                            activeColor: azulFretum,
                            onChanged: (bool value){
                              setState(() {
                                checkBoxValue = value;
                              });
                            },
                          ),
                          Text("Recordar mis datos",
                          style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 30.0),

                      //boton de login
                      Container(
                        width: double.infinity,
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () async {
                            if(cContra.text.toString().isEmpty || cEmail.text.toString().isEmpty){
                              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Por favor llena los campos vacios')));
                            }else{
                              setState(() {
                                _colorCubo = azulFretum;
                              });
                              dynamic result = await _auth.signInWithEmailAndPassword(cEmail.text.toString(), cContra.text.toString());

                              if(result == null){
                                setState(() {
                                  _colorCubo = Colors.transparent;
                                });
                                _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Correo o contraseña incorrecto')));
                              }else{
                                if (checkBoxValue == true){
                                  save();
                                }else{
                                  localStorage.clear();
                                }
                                //mostrar Toast personalizado
                               _showToast();
                                Navigator.pushReplacementNamed(context, '/citas');
                              }
                            }
                          },
                          child: Text("Iniciar sesión",
                          style: estiloBlanco),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          color: azulFretum,
                          elevation: 3.0,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        width: double.infinity,
                        height: 50.0,
                        child: FlatButton(
                          onPressed: (){
                            Navigator.pushReplacementNamed(context, '/register');
                          },
                          child: Text("Regístrate", style: estiloBlanco),
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      FlatButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, '/olvide_contra');
                        },
                        child: Text("¿Olvidaste tu contraseña?",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16.0,
                          decoration: TextDecoration.underline
                        )),
                      ),
                      SpinKitFadingCube(
                        color: _colorCubo,
                        size: 40.0,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}