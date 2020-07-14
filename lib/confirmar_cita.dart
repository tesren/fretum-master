import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ConfirmarCita extends StatefulWidget {
  @override
  _ConfirmarCitaState createState() => _ConfirmarCitaState();
}

class _ConfirmarCitaState extends State<ConfirmarCita> {

  Map _datos = {};
  Set<Marker> markers = Set();
  GoogleMapController  _mapController;

  @override
  Widget build(BuildContext context) {

    _datos = ModalRoute.of(context).settings.arguments;

    LatLng direccion = _datos['latlong'];
    int autoChico = _datos['autoChico'];
    int soloLauto = _datos['soloLauto'];
    int camioChica = _datos['camioChica'];
    int soloLcamio = _datos['soloLcamio'];
    int motos = _datos['motos'];

    markers = Set();
    markers.add(Marker(
      markerId: MarkerId("target"),
      position: direccion,
    ),
    );

    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacementNamed(context, '/fechayhora');
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
              Text("Datos de la cita",
                  style: estiloBlanco),
            ],
          ),
          backgroundColor: azulFretum,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pushReplacementNamed(context, '/fechayhora'),
          ),
        ),

        bottomNavigationBar:  SizedBox( height: 55, width: double.infinity,
          child: BottomAppBar(
          color: azulFretum,
            child: FlatButton(
             child: Stack(
              children: <Widget>[
                Align(alignment: Alignment.center, child: Text('Confirmar cita', style: estiloBlanco)),
                //Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_forward, color: Colors.white,))
              ],
            ),
            onPressed: (){
              print(_datos);
            },
          ),
          elevation: 5,
        ),
       ),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                Container(
                  width: double.infinity,
                  height: 200,
                  margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400], width: 5)
                  ),

                  child: direccion == null ? Container(
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
                        target: direccion,
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
                Text("Dirección "  , style: estiloNegro ),
                Text("" + _datos['direccion'].toString(), style:  estiloGris,),
                SizedBox(height: 5),

                //contenedor de fecha y tiempo
                Container(
                  width: double.infinity,
                  height: 75,
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
                          Text("Fecha y hora: " + _datos['fecha'].toString() + ", " + _datos['hora'].toString() ,style: estiloNegro),
                        ],
                      ),
                      SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.timer),
                          SizedBox(width: 5),
                          Text("Tiempo estimado del lavado: "  ,style: estiloNegro),
                      ],
                      )
                    ],
                  ),
                ),

                //contenedor de cuantos autos
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
                            Text("   MXN\$", style: estiloCarros,)
                          ],
                        ),

                        soloLauto == 0 ?
                        SizedBox(width: 0, height: 0,):
                        Row(
                          children: <Widget>[
                            Text(soloLauto.toString() + "X", style: estiloAzul,),
                            SizedBox(width: 5),
                            Expanded(child: Text("Solo lavado auto chico",style: estiloCarros,)),
                            Text("   MXN\$", style: estiloCarros,)
                          ],
                        ),

                        camioChica == 0 ?
                        SizedBox(width: 0, height: 0,):
                        Row(
                          children: <Widget>[
                            Text(camioChica.toString() + "X", style: estiloAzul,),
                            SizedBox(width: 5),
                            Expanded(child: Text("Lavado y aspirado de camioneta chica",style: estiloCarros,)),
                            Text("   MXN\$", style: estiloCarros,)
                          ],
                        ),

                        soloLcamio == 0 ?
                        SizedBox(width: 0, height: 0,):
                        Row(
                          children: <Widget>[
                            Text(soloLcamio.toString() + "X", style: estiloAzul,),
                            SizedBox(width: 5),
                            Expanded(child: Text("Solo lavado camioneta chica",style: estiloCarros,)),
                            Text("   MXN\$", style: estiloCarros,)
                          ],
                        ),

                        motos == 0 ?
                        SizedBox(width: 0, height: 0,):
                        Row(
                          children: <Widget>[
                            Text(motos.toString() + "X", style: estiloAzul,),
                            SizedBox(width: 5),
                            Expanded(child: Text("Solo lavado moto",style: estiloCarros,)),
                            Text("   MXN\$", style: estiloCarros,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                //contenedor de precio total
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
                        Text("MXN\$", style: estiloNegro),
                      ],
                    ),
                  ),

                ),

                //contenedor de método de pago
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
                        Icon(Icons.attach_money),
                        Text("Efectivo", style: estiloNegro),
                      ],
                    ),
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
