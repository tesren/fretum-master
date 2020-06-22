import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fretummaster/citas.dart';
import 'colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

  var txt = TextEditingController();

  @override
  Widget build(BuildContext context) {

    txt.text = "Erick";
    double pRating = 5.0;

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
            Text("Perfil",
                style: estiloBlanco),
          ],
        ),
        backgroundColor: azulFretum,
      ),
      drawer: crearDrawer(context),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              CircleAvatar(
               /* child: Image(
                    image: AssetImage("assets/ic_launcher_round.png"),fit: BoxFit.contain,),
                */
                backgroundImage: AssetImage("assets/profilepic.png"),
                backgroundColor: Colors.grey,
                radius: 60.0,
              ),
              SizedBox(height: 30.0),
              Text("Nombre(s)", style: estiloGris,),
              Container(
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
                    Expanded(child: Text("Erick Alejandro", style: estiloNegro,)),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20.0,),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text("Apellidos",style: estiloGris),
              Container(
                width: 320.0, height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1.0, 0.0, 5.0, 0.0),
                      child: Icon(Icons.font_download, color: Colors.grey, size: 32.0,),
                    ),
                    Expanded(child: Text("Pérez Macedo", style: estiloNegro, overflow: TextOverflow.ellipsis, maxLines: 1,)),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20.0,),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Text("Correo electrónico", style: estiloGris,),
              Container(
                width: 320.0, height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1.0, 0.0, 5.0, 0.0),
                      child: Icon(Icons.email, color: Colors.grey, size: 35.0,),
                    ),
                    Flexible(child: Text("tesren@live.com.mx", style: estiloNegro, overflow: TextOverflow.ellipsis, maxLines: 1,)),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Text("Teléfono", style: estiloGris,),
              Container(
                width: 320.0, height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1.0, 0.0, 5.0, 0.0),
                      child: Icon(Icons.local_phone, color: Colors.grey, size: 35.0,),
                    ),
                    Expanded(child: Text("(322) 108-4847", style: estiloNegro, overflow: TextOverflow.ellipsis, maxLines: 1,)),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Text("Contraseña", style: estiloGris,),
              Container(
                width: 320.0, height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1.0, 0.0, 5.0, 0.0),
                      child: Icon(Icons.lock, color: Colors.grey, size: 35.0,),
                    ),
                    Expanded(child: Text("************", style: estiloNegro, overflow: TextOverflow.ellipsis, maxLines: 1,)),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20.0,),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Text("Calificación de usuario", style: estiloGris),
              RatingBarIndicator(
                rating: pRating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: azulFretum,
                ),
                itemCount: 5,
                itemSize: 50.0,
                direction: Axis.horizontal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
