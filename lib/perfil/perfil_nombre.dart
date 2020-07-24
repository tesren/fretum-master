import 'package:flutter/material.dart';
import 'package:fretummaster/services/user_model.dart';
import 'package:fretummaster/colors.dart';

class PerfilNombre extends StatelessWidget {

  final Usuarios usuario;
  PerfilNombre({this.usuario});


  @override
  Widget build(BuildContext context) {

    return Container(
      child:   InkWell(
        onTap: (){
          Navigator.pushReplacementNamed(context, '/cambiarNombre');
        },
        child: Container(
          width: 320.0, height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(1.0, 0.0, 5.0, 0.0),
                child: Icon(Icons.account_circle, color: Colors.grey, size: 35.0,),
              ),
              Expanded(
                  child: Text("Erick", style: estiloNegro,)),
              Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20.0,),
            ],
          ),
        ),
      ),
    );
  }
}
