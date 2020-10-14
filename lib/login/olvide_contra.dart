import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fretummaster/colors.dart';
import 'package:fretummaster/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Olvide_contra extends StatefulWidget {
  @override
  _Olvide_contraState createState() => _Olvide_contraState();
}

class _Olvide_contraState extends State<Olvide_contra> {

  final AuthService _auth = AuthService();
  final _email = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FToast fToast;
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: azulFretum,
    ),
    child: Row(
      children: <Widget>[
        Icon(Icons.email, color: Colors.white),
        Text(" Por favor revisa tu correo", style: TextStyle(fontSize: 14, color: Colors.white)),
      ],
    ),
  );
  _showToast() {
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {

    fToast = FToast(context);

    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacementNamed(context, '/login');
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
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
              Text("Recuperar contraseña",
              style: estiloBlanco),
            ],
          ),
          backgroundColor: azulFretum,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 20.0),

                  //correo
                  child: TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 60,
                    maxLines: 1,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.grey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: "Correo electrónico"
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  margin: EdgeInsets.fromLTRB(30, 5, 30, 5),

                  //boton para recuperar contraseña
                  child: RaisedButton(
                    onPressed: ()async{
                      await _auth.sendPassResetEmail(_email.text.toString().trim());
                     _showToast();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    color: azulFretum,
                    child: Text("Enviar a mi correo",
                    style: estiloBlanco),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Te enviaremos un enlace al correo que indicaste para que cambies tu contraseña y puedas ingresar a tu cuenta",
                  style: TextStyle(
                    color: secondaryText,
                  ),
                    textAlign: TextAlign.center,
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
