import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fretummaster/colors.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  Map data = {};
  bool checkBoxValue = true;
  Color _colorCubo = Colors.transparent;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //data = ModalRoute.of(context).settings.arguments;

    // set background image
   // String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    //Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      appBar: AppBar(
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
                      TextField(
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
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword ,
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
                      Container(
                        width: double.infinity,
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: (){
                            Navigator.pushReplacementNamed(context, '/citas');
                            setState(() {
                              _colorCubo = azulFretum;
                            });
                          },
                          child: Text("Iniciar sesión",
                          style: estiloBlanco),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          color: azulFretum,
                          elevation: 3.0,
                          highlightColor: Colors.blueAccent[800],
                        ),
                      ),
                      SizedBox(height: 15.0),
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