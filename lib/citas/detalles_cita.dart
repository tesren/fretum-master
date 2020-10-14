import 'dart:ffi';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fretummaster/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetallesCita extends StatefulWidget {
  @override
  _DetallesCitaState createState() => _DetallesCitaState();
}

class _DetallesCitaState extends State<DetallesCita> {

  final db = Firestore.instance;
  Map _datos = {};
  Set<Marker> markers = Set();
  GoogleMapController  _mapController;

  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  FToast fToast;

  Widget _toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.red,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.delete_forever, color: Colors.white),
        SizedBox(
          width: 12.0,
        ),
        Text("Cita borrada", style: TextStyle(fontSize: 14, color: Colors.white),),
      ],
    ),
  );

  _showToast() {
    fToast.showToast(
      child: _toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {

    _datos = ModalRoute.of(context).settings.arguments;
    String id = _datos['id'];
    fToast = FToast(context);

    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushReplacementNamed(context, '/citas');
        return false;
      },

      child: StreamBuilder<DocumentSnapshot>(
        stream: db.collection('citas').document(id).snapshots(),
        builder: (contexto, snapshot) {
          if(snapshot.hasData){

            //convierto strings a LATLONG
            String direccionLatLong = snapshot.data['LatLong'] ?? '0,0' ;
            List<String> LatLong = direccionLatLong.split(",");
            double latitud = double.tryParse(LatLong[0]);
            double longitud = double.tryParse(LatLong[1]);
            LatLng ubicacionConvertida = new LatLng(latitud, longitud);


            //autos
            String autoChicoS = snapshot.data['autoChico'];
            int autoChico = int.tryParse(autoChicoS);
            String camioChicaS = snapshot.data['camioChica'];
            int camioChica = int.tryParse(camioChicaS);
            String SoloLChicoS = snapshot.data['soloLChico'];
            int soloLauto = int.tryParse(SoloLChicoS);
            String soloLcamioChicaS = snapshot.data['soloLCamioChica'];
            int soloLcamio = int.tryParse(soloLcamioChicaS);
            String motosS = snapshot.data['motos'];
            int motos = int.tryParse(motosS);

            //costos de los servicios
            int pAutoChico = 99;
            int pSoloLchico = 69;
            int pCamioChica = 149;
            int pSoloLchica = 99;
            int pMotos = 49;


            markers = Set();
            markers.add(Marker(
              markerId: MarkerId("target"),
              position: ubicacionConvertida,
            ),
            );

            return Scaffold(
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
                    Text("Datos de la cita",
                        style: estiloBlanco),
                  ],
                ),
                backgroundColor: azulFretum,
                automaticallyImplyLeading: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pushReplacementNamed(contexto, '/citas',),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[

                      //mapa de la ubicacion
                      Container(
                        width: double.infinity,
                        height: 200,
                        margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[400], width: 3.5)
                        ),

                        child: direccionLatLong == null ? Container(
                          child: Center(
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Cargando Mapa..', style: estiloGris,),
                                SizedBox(height: 20),
                                SpinKitFadingCube(
                                  color: azulFretum,
                                  size: 40,
                                )
                              ],
                            ),),) :


                        //mapa para mostrar la ubicacion del lavado
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: ubicacionConvertida,
                            zoom: 18,
                          ),
                          zoomGesturesEnabled: false,
                          markers: markers,
                          myLocationEnabled: false,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          scrollGesturesEnabled: false,
                          onMapCreated: (controller) => _mapController = controller,
                        ),
                      ),

                      //widgets para mostrar direccion
                      Text("Dirección: "  , style: estiloNegro, textAlign: TextAlign.center),
                      Text(snapshot.data['direccion'].toString(), style:  estiloGris, textAlign: TextAlign.center,),
                      SizedBox(height: 5),

                      //contenedor de fecha y tiempo
                      Container(
                        width: double.infinity,
                        //height: 95,
                        decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey[400], width: 2), bottom: BorderSide(color: Colors.grey[400], width: 2))
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.calendar_today),
                                SizedBox(width: 5),
                                Text("Fecha y hora: " + snapshot.data['fecha'].toString() + ", " + snapshot.data['hora'].toString() ,style: estiloNegro),
                              ],
                            ),
                            SizedBox(height: 7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.timer),
                                SizedBox(width: 5),
                                Text("Tiempo estimado del lavado: " + snapshot.data['tiempo'].toString() + " horas",style: estiloNegro),
                              ],
                            ),
                            SizedBox(height: 7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.phone),
                                SizedBox(width: 5),
                                Text("Teléfono del cliente: ${snapshot.data['telefono']}"  ,style: estiloNegro),
                              ],
                            ),
                            SizedBox(height: 3),
                          ],
                        ),
                      ),

                      //contenedor de autos
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border( bottom: BorderSide(color: Colors.grey[400], width: 2) )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Tus autos", style: estiloAzul,),

                              autoChico == 0 ?
                              SizedBox(width: 0, height: 0,):
                              Row(
                                children: <Widget>[
                                  Text(autoChico.toString() + "X", style: estiloAzul,),
                                  SizedBox(width: 5),
                                  Expanded(child: Text("Lavado y aspirado auto chico",style: estiloCarros,)),
                                  Text("MXN\$" + (autoChico * pAutoChico).toString() , style: estiloCarros,)
                                ],
                              ),

                              soloLauto == 0 ?
                              SizedBox(width: 0, height: 0,):
                              Row(
                                children: <Widget>[
                                  Text(soloLauto.toString() + "X", style: estiloAzul,),
                                  SizedBox(width: 5),
                                  Expanded(child: Text("Solo lavado auto chico",style: estiloCarros,)),
                                  Text("MXN\$" + (soloLauto * pSoloLchico).toString() , style: estiloCarros,)
                                ],
                              ),

                              camioChica == 0 ?
                              SizedBox(width: 0, height: 0,):
                              Row(
                                children: <Widget>[
                                  Text(camioChica.toString() + "X", style: estiloAzul,),
                                  SizedBox(width: 5),
                                  Expanded(child: Text("Lavado y aspirado de camioneta chica",style: estiloCarros,)),
                                  Text("MXN\$" + (camioChica * pCamioChica).toString(), style: estiloCarros,)
                                ],
                              ),

                              soloLcamio == 0 ?
                              SizedBox(width: 0, height: 0,):
                              Row(
                                children: <Widget>[
                                  Text(soloLcamio.toString() + "X", style: estiloAzul,),
                                  SizedBox(width: 5),
                                  Expanded(child: Text("Solo lavado camioneta chica",style: estiloCarros,)),
                                  Text("MXN\$" + (soloLcamio * pSoloLchica).toString() , style: estiloCarros,)
                                ],
                              ),

                              motos == 0 ?
                              SizedBox(width: 0, height: 0,):
                              Row(
                                children: <Widget>[
                                  Text(motos.toString() + "X", style: estiloAzul,),
                                  SizedBox(width: 5),
                                  Expanded(child: Text("Solo lavado moto",style: estiloCarros,)),
                                  Text("MXN\$" + (pMotos * motos).toString(), style: estiloCarros,)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      //contenedor de total
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border( bottom: BorderSide(color: Colors.grey[400], width: 2) )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Text("Total", style: estiloAzul)),
                              Text("MXN\$" + snapshot.data['total'].toString() , style: TextStyle(color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),

                      //contenedor de metodo de pago
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border( bottom: BorderSide(color: Colors.grey[400], width: 2) )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Text("Método de pago", style: estiloAzul)),
                              Icon(Icons.monetization_on),
                              Text(snapshot.data['metodo'].toString(), style: estiloNegro),
                            ],
                          ),
                        ),
                      ),

                      //contenedor de notas
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border( bottom: BorderSide(color: Colors.grey[400], width: 2) )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Text("Notas", style: estiloAzul) ),
                              Flexible(child: Text(snapshot.data['notas'].toString(), style: estiloNegro, maxLines: 3, overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 45,
                        margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: RaisedButton(
                          onPressed: (){
                            _launchMapsUrl(latitud, longitud);
                          },
                          color: azulFretum,
                          elevation: 5,
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Text("Abrir ubicación en Google Maps", style: estiloBlanco, overflow: TextOverflow.ellipsis, maxLines: 1,)),
                              Icon(Icons.arrow_forward_ios, color: Colors.white,)
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                        ),
                      ),

                      //Boton para borrar citas
                      FlatButton(
                        onPressed: (){
                          // borrar cita
                          showDialog(context: context,
                              builder: (_dialogContext) => AlertDialog(
                                title: Row(
                                  children: <Widget>[
                                    Icon(Icons.delete_forever),
                                    Text("  Eliminar cita definitivamente", style: estiloNegro,),
                                  ],
                                ),
                                content: Text("¿Estás seguro de eliminar esta cita? \n Esta acción es irreversible", style: estiloGris,),
                                actions: <Widget>[
                                  FlatButton(child: Text("Cancelar"),
                                    onPressed: (){
                                      Navigator.pop(_dialogContext);
                                    },),
                                  FlatButton(child: Text("Si"),
                                    onPressed: ()async{
                                      await db.collection("citas").document(id).delete();
                                      Navigator.pop(_dialogContext);
                                      _showToast();
                                      Navigator.pushReplacementNamed(context, '/citas');
                                    },)
                                ],
                                elevation: 20.0,
                                backgroundColor: Colors.grey[100],
                              ),
                              barrierDismissible: true);
                        },
                        child: Text("Eliminar cita", style: TextStyle(color: Colors.red, fontSize: 16),),
                      )
                    ],
                  ),
                ),
              ),
            );
          }else{
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
      ),
    );
  }
}
