import 'package:flutter/material.dart';
import 'package:fretummaster/colors.dart';

class Olvide_contra extends StatefulWidget {
  @override
  _Olvide_contraState createState() => _Olvide_contraState();
}

class _Olvide_contraState extends State<Olvide_contra> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacementNamed(context, '/login');
        return false;
      },
      child: Scaffold(
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
                  padding: const EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 30.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email, color: Colors.grey),
                        hintText: "ejemplo@mail.com",
                        labelText: "Correo electrónico"
                    ),
                  ),
                ),
                Container(
                  width: 300.0,
                  height: 45.0,
                  child: RaisedButton(
                    onPressed: (){},
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
