import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CambiarContra extends StatefulWidget {
  @override
  _CambiarContraState createState() => _CambiarContraState();
}

class _CambiarContraState extends State<CambiarContra> {

  Color _colorCubo = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacementNamed(context, '/perfil');
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
              Text("Cambiar contraseña",
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
            padding: const EdgeInsets.fromLTRB(25.0,15.0,25.0, 20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: "Contraseña actual",
                  ),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                ),
                SizedBox(height: 15.0),
                TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: "Contraseña nueva",
                  ),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                ),
                SizedBox(height: 15.0),
                TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: "Confirmar contraseña",
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  width: double.infinity, height: 55,
                  child: RaisedButton(
                    elevation: 4.0,
                    color: azulFretum,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Text("Guardar cambios", style:  estiloBlanco,),
                    onPressed: (){
                      setState(() {
                        _colorCubo = azulFretum;
                      });
                      Navigator.pushReplacementNamed(context, '/perfil');
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
  }
}
