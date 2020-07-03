import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CambiarNombre extends StatefulWidget {
  @override
  _CambiarNombreState createState() => _CambiarNombreState();
}

class _CambiarNombreState extends State<CambiarNombre> {
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
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    //icon: Icon(Icons.shopping_basket, color: Colors.grey),
                    //hintText: "Nombre",
                    labelText: "Nombre",
                  ),
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
