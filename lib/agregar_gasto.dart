import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:address_search_field/address_search_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AgregarGasto extends StatefulWidget {
  @override
  _AgregarGastoState createState() => _AgregarGastoState();
}

class _AgregarGastoState extends State<AgregarGasto> {

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  TextEditingController _controllerAdress = TextEditingController();
  final db = Firestore.instance;

  DateTime _dateTime;
  String convertedDate;
  final List<String> metodos =['Efectivo', 'Tarjeta', 'Otro'];
  String _currentMetod;
  String _nombre= "";
  String _monto = "0";
  String _descripcion = "";
  String _lugar = "";

  @override
  Widget build(BuildContext context) {

    String dropdownValue = 'Efectivo';
    return WillPopScope(
      onWillPop: () async {
      Navigator.pushReplacementNamed(context, '/gastos');
      return false;
    },

      child: Scaffold(
        key: _key,
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
              Text("Agregar un gasto",
                  style: estiloBlanco),
            ],
          ),
          backgroundColor: azulFretum,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pushReplacementNamed(context, '/gastos'),
          ),
        ),

        //boton para insertar a la base de datos
        bottomNavigationBar: SizedBox( height: 55, width: double.infinity,
          child: BottomAppBar(
            color: azulFretum,
            child: FlatButton(
                child: Stack(
                  children: <Widget>[
                    Align(alignment: Alignment.center, child: Text('Agregar gasto', style: estiloBlanco)),
                    Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_forward, color: Colors.white,))
                  ],
                ),
              onPressed: () async {
                  DocumentReference ref = await db.collection("gastos").add({
                    'nombre': '$_nombre',
                    'descripcion': '$_descripcion',
                    'lugar': '$_lugar',
                    'fecha': '$convertedDate',
                    'monto': '$_monto',
                    'metodo': '$_currentMetod'
                  });

                  Fluttertoast.showToast(
                      msg: "Gasto registrado",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey[400],
                      textColor: Colors.white,
                      fontSize: 16.0
                  );

                  Navigator.pushReplacementNamed(context, '/gastos');
              },
            ),
            elevation: 0,
          ),
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 0.0),
              child: Column(
                children: <Widget>[

                  //nombre
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.shopping_basket),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        //icon: Icon(Icons.shopping_basket, color: Colors.grey),
                        //hintText: "Nombre",
                      labelText: "Nombre",
                    ),
                    onChanged: (val) {
                      setState(() => _nombre = val);
                    },
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  ),
                  SizedBox(height: 20.0),

                  //Descripción
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.description),
                      labelText: "Descripción"
                    ),
                    onChanged: (val) {
                      setState(() => _descripcion = val);
                    },
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  ),
                  SizedBox(height: 20.0),

                 //Lugar
                  AddressSearchField(
                    controller: _controllerAdress,
                    country: "México",
                    city: "Puerto Vallarta",
                    hintText: "Lugar",
                    noResultsText: "No hay resultados",
                    onDone: (AddressPoint point) async{
                       _lugar = point.address;
                      _controllerAdress.text = _lugar;
                      Navigator.pop(context);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.add_location),
                        labelText: "Lugar"
                    ),
                  ),
                  SizedBox(height: 20.0),

                 //fecha
                 Container(
                   height: 55, width: double.infinity,
                   child: RaisedButton(
                     elevation: 3.0,
                     color: Colors.white,
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10.0),
                     ),
                     child: Row(
                       children: <Widget>[
                         Icon(Icons.calendar_today, color: Colors.grey),
                         SizedBox(width: 10),
                         Text( _dateTime == null? "Elegir fecha": convertedDate,
                           style: estiloGris),
                       ],
                     ),
                     onPressed: (){
                       showDatePicker(
                           context: context,
                           locale: Locale('es','MX'),
                           initialDate: DateTime.now(),
                           firstDate: DateTime(2020),
                           lastDate: DateTime(2030,)).then((date){
                         setState(() {
                           _dateTime = date;
                           convertedDate = new DateFormat("dd-MM-yyyy").format(_dateTime);
                         });
                       });
                     },
                   ),
                 ),
                  SizedBox(height: 20.0),

                  //monto
                  TextField(
                    keyboardType: TextInputType.number,
                    //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.attach_money),
                        labelText: "Monto"
                    ),
                    onChanged: (val) {
                      setState(() => _monto = val);
                    },
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  ),
                  SizedBox(height: 20.0),

                  //método de pago
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.monetization_on),
                    ),
                    value: _currentMetod??'Efectivo',
                    items: metodos.map((metodo){
                      return DropdownMenuItem(
                        value: metodo,
                        child: Text("$metodo",
                        style: TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentMetod = val),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
