import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'colors.dart';
import 'package:address_search_field/address_search_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Agregar_cita extends StatefulWidget {
  @override
  _Agregar_citaState createState() => _Agregar_citaState();
}


class _Agregar_citaState extends State<Agregar_cita> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  GoogleMapController  _mapController;
  Location _location = Location();
  LatLng target = LatLng(0,0);
  Set<Marker> markers = Set();
  TextEditingController controllerAdress = TextEditingController();
  String Adress = "";
  //final double hueFretum = 207.1;
  LatLng _initialPosition ;
  LatLng posicion;


  @override
  void initState() {
    super.initState();
    _initLocation();
    _getUserLocation();
  }

  void _getUserLocation() async {
    Position position = await Geolocator().getCurrentPosition();
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      print('${placemark[0].name}');
    });
  }

  _initLocation() async {
    var _serviceEnabled = await _location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled = await _location.requestService();
      if(!_serviceEnabled){
        return;
      }
    }
    var _permisionGranted = await _location.hasPermission();
    if(_permisionGranted == PermissionStatus.denied){
      _permisionGranted = await _location.requestPermission();
    }
    if(_permisionGranted != PermissionStatus.granted){
      print("sin permiso");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/citas');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
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
              Text("Selecciona ubicación",
                  style: estiloBlanco),
            ],
          ),
          backgroundColor: azulFretum,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pushReplacementNamed(context, '/citas'),
          ),
        ),

        bottomNavigationBar: SizedBox(height: 55, width: double.infinity,
          child: BottomAppBar(
            color: azulFretum,
            child: FlatButton(
              child: Stack(
                children: <Widget>[
                  Align(alignment: Alignment.center,
                      child: Text('Siguiente', style: estiloBlanco)),
                  Align(alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward, color: Colors.white,))
                ],
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/agregarCarros', arguments:{
                  'direccion': Adress,
                  'latlong': posicion
                });
              },
            ),
            elevation: 0,
          ),
        ),

        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                color: azulFretum,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),

                  child: AddressSearchField(
                    controller: controllerAdress,
                    country: "México",
                    city: "Puerto Vallarta",
                    hintText: "Dirección",
                    noResultsText: "No hay resultados",

                    onDone: (AddressPoint point) async{
                      target = LatLng(point.latitude, point.longitude);
                      setState(() {
                        Adress = point.address;
                        controllerAdress.text = Adress;
                        posicion = LatLng(point.latitude, point.longitude);

                        markers = Set();
                        markers.add(Marker(
                          markerId: MarkerId("target"),
                          position: target,
                        ),
                        );
                      });
                      _mapController.animateCamera(CameraUpdate.newLatLng(target));

                      Navigator.pop(context);
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.add_location),
                        labelText: "Escriba la dirección",
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _initialPosition == null ? Container(
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
                GoogleMap(
                  onLongPress: (LatLong){
                    _addMarkerLongPressed(LatLong);
                  },
                  initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 16
                  ),
                  zoomGesturesEnabled: true,
                  markers: markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: (controller) => _mapController = controller,
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
  Future _addMarkerLongPressed(LatLng LatLong) async {
    setState(() {
      markers = Set();
      markers.add(Marker(
        markerId: MarkerId("target"),
        position: LatLong,
       // icon: BitmapDescriptor.defaultMarkerWithHue(hueFretum),
      ),
      );
      Adress = LatLong.toString().substring(6);
      controllerAdress.text = Adress;
      posicion = LatLong;

    });
    _mapController.animateCamera(CameraUpdate.newLatLng(LatLong));
    //This is optional, it will zoom when the marker has been created
    //GoogleMapController controller = await _controller.future;
   // controller.animateCamera(CameraUpdate.newLatLngZoom(LatLong, 17.0));
  }


}
