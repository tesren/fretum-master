import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class AgregarCarros extends StatefulWidget {
  @override
  _AgregarCarrosState createState() => _AgregarCarrosState();
}

class _AgregarCarrosState extends State<AgregarCarros> {

  int autoChico = 0;
  int soloLauto = 0;
  int camioChica = 0;
  int soloLcamio = 0;
  int motos = 0;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacementNamed(context, '/agregar_cita');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                child: Image(
                  image: AssetImage("assets/ic_launcher_round.png"),
                  fit: BoxFit.contain,
                  height: 32,
                ),
              ),
              Text("Indique el tipo de servicio",
                  style: estiloBlanco),
            ],
          ),
          backgroundColor: azulFretum,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pushReplacementNamed(context, '/agregar_cita'),
          ),
        ),
        bottomNavigationBar: SizedBox( height: 55, width: double.infinity,
          child: BottomAppBar(
            color: azulFretum,
            child: FlatButton(
              child: Stack(
                children: <Widget>[
                  Align(alignment: Alignment.center, child: Text('Siguiente', style: estiloBlanco)),
                  Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_forward, color: Colors.white,))
                ],
              ),
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/fechayhora');
              },
            ),
            elevation: 0,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  margin: EdgeInsets.all(8.0),
                  elevation: 5.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity, height: 100,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5.0,0.0,8.0,0.0),
                              child: Image(
                                image: AssetImage("assets/auto_chico.png"),
                                fit: BoxFit.contain,
                                height: 37,
                              ),
                            ),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Auto chico", style: estiloAzul,),
                                    Text("Auto compacto, subcompacto, o familiar pequeño", style: estiloGris,),
                                  ],
                                ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                backgroundColor: azulFretum,
                                radius: 45.0,
                                  child: Text("\$99.00", style: estiloBlanco,),
                            ),),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Lavado y aspirado", style: estiloAzul,),
                                  Text("Aspirado total de interiores y lavado de carrocería, llantas y rines", style: estiloGris,),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove),
                              color: azulFretum,
                              onPressed: (){
                                setState(() {
                                  if(autoChico==0){
                                  }else{
                                    autoChico--;
                                  }
                                });
                              },
                            ),
                            Text("$autoChico",style: estiloNegro),
                            IconButton(
                              icon: Icon(Icons.add),
                              color: azulFretum,
                              onPressed: (){
                                setState(() {
                                  autoChico++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                          Container(
                              child: Row(
                              children: <Widget>[
                                Padding(
                                padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: azulFretum,
                                    radius: 45.0,
                                    child: Text("\$69.00", style: estiloBlanco,),
                                  ),),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Solo Lavado", style: estiloAzul,),
                                      Text("Lavado de carrocería, llantas y rines", style: estiloGris),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  color: azulFretum,
                                  onPressed: (){
                                    setState(() {
                                      if(soloLauto==0){
                                      }else{
                                        soloLauto--;
                                      }
                                    });

                                  },
                                ),
                                Text("$soloLauto",style: estiloNegro),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  color: azulFretum,
                                  onPressed: (){
                                    setState(() {
                                      soloLauto++;
                                    });
                                  },
                                ),
                      ],
                    ),
                  ),
                    ],
                  ),
                ),

                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  margin: EdgeInsets.all(8.0),
                  elevation: 5.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity, height: 100,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5.0,0.0,8.0,0.0),
                              child: Image(
                                image: AssetImage("assets/camioneta_chica.png"),
                                fit: BoxFit.contain,
                                height: 45,
                              )
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Camioneta chica", style: estiloAzul,),
                                  Text("Camioneta SUV, crossover o todoterreno, sin caja", style: estiloGris),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: azulFretum,
                                radius: 45.0,
                                child: Text("\$149.00", style: estiloBlanco,),
                              ),),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Lavado y aspirado", style: estiloAzul,),
                                  Text("Aspirado total de interiores y lavado de carrocería, llantas y rines", style: estiloGris,),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove),
                              color: azulFretum,
                              onPressed: (){
                                setState(() {
                                  if(camioChica!=0){
                                    camioChica--;
                                  }
                                });
                              },
                            ),
                            Text("$camioChica",style: estiloNegro),
                            IconButton(
                              icon: Icon(Icons.add),
                              color: azulFretum,
                              onPressed: (){
                                setState(() {
                                  camioChica++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: azulFretum,
                                radius: 45.0,
                                child: Text("\$99.00", style: estiloBlanco,),
                              ),),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Solo Lavado", style: estiloAzul,),
                                  Text("Lavado de carrocería, llantas y rines", style: estiloGris),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove),
                              color: azulFretum,
                              onPressed: (){
                                setState(() {
                                  if(soloLcamio != 0){
                                    soloLcamio--;
                                  }
                                });

                              },
                            ),
                            Text("$soloLcamio",style: estiloNegro),
                            IconButton(
                              icon: Icon(Icons.add),
                              color: azulFretum,
                              onPressed: (){
                                setState(() {
                                  soloLcamio++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  margin: EdgeInsets.all(8.0),
                  elevation: 5.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity, height: 100,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5.0,0.0,8.0,0.0),
                              child: Image(
                                image: AssetImage("assets/moto.png"),
                                fit: BoxFit.contain,
                                height: 65,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Motos", style: estiloAzul,),
                                  Text("De 2 a 4 llantas", style: estiloGris),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: azulFretum,
                                radius: 45.0,
                                child: Text("\$49.00", style: estiloBlanco,),
                              ),),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Solo Lavado", style: estiloAzul,),
                                  Text("Lavado de carrocería, llantas y rines", style: estiloGris),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove),
                              color: azulFretum,
                              onPressed: (){
                                setState(() {
                                  if(motos != 0){
                                    motos--;
                                  }
                                });
                              },
                            ),
                            Text("$motos",style: estiloNegro),
                            IconButton(
                              icon: Icon(Icons.add),
                              color: azulFretum,
                              onPressed: (){
                                setState(() {
                                  motos++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
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
