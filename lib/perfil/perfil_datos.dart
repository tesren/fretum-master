import 'package:flutter/material.dart';
import 'package:fretummaster/services/database.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fretummaster/services/user_model.dart';
import 'package:fretummaster/services/user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class DatosPerfil extends StatefulWidget {
  @override
  _DatosPerfilState createState() => _DatosPerfilState();
}

class _DatosPerfilState extends State<DatosPerfil> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context) ;
    //print(user);
    double pRating = 5.0;


    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      // ignore: missing_return
      builder: (contexto, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;

          return Container(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/outline_account_circle_black_48pt_3x.png"),
                        backgroundColor: Colors.white,
                        radius: 60.0,
                      ),
                      SizedBox(height: 30.0),
                      Text("Nombre(s)", style: estiloGris,),

                      //nombre de usuario
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(contexto, '/cambiarNombre');
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
                                  child: Text("${userData.nombre}", style: estiloNegro,)),
                              Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20.0,),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text("Apellidos",style: estiloGris),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(contexto, '/cambiarApellidos');
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
                                child: Icon(Icons.font_download, color: Colors.grey, size: 32.0,),
                              ),
                              Expanded(child: Text("${userData.apellidos}", style: estiloNegro, overflow: TextOverflow.ellipsis, maxLines: 1,)),
                              Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20.0,),
                            ],
                          ),
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
                            Flexible(child: Text("${userData.correo}", style: estiloNegro, overflow: TextOverflow.ellipsis, maxLines: 1,)),
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
                            Expanded(child: Text("${userData.telefono}", style: estiloNegro, overflow: TextOverflow.ellipsis, maxLines: 1,)),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text("Contraseña", style: estiloGris,),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(contexto, '/cambiarContra');
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
                                child: Icon(Icons.lock, color: Colors.grey, size: 35.0,),
                              ),
                              Expanded(child: Text("************", style: estiloNegro, overflow: TextOverflow.ellipsis, maxLines: 1,)),
                              Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20.0,),
                            ],
                          ),
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
            ),
          );
        }
        else{
          return Container(
            child: Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Cargando datos..', style: estiloGris,),
                  SizedBox(height: 20),
                  SpinKitFadingCube(
                    color: azulFretum,
                    size: 40,
                  )
                ],
              ),
            ),
          );
        }
      }
    );
  }
}




