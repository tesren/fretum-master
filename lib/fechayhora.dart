import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'colors.dart';



class FechayHora extends StatefulWidget {
  @override
  _FechayHoraState createState() => _FechayHoraState();
}

class _FechayHoraState extends State<FechayHora> {
  DateTime _dateTime;
  String convertedDate;
  Map _datos = {};
  TimeOfDay _hora;
  String notas="";
  String telefonoCliente = "";


  final List<String> Lavadores =['Joaquín Mercado', 'Erick Pérez', 'Luis Monroy', 'Juan Gonzalez'];
  String _currentLavador = 'Joaquín Mercado';


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    _datos = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushReplacementNamed(context, '/agregarCarros', arguments: {
          'direccion': _datos['direccion'],
          'latlong' : _datos['latlong'],
        });
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
              Text("Indique la fecha y hora",
                  style: estiloBlanco),
            ],
          ),
          backgroundColor: azulFretum,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pushReplacementNamed(context, '/agregarCarros', arguments: {
              'direccion': _datos['direccion'],
              'latlong' : _datos['latlong'],
            }),
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
                Navigator.pushReplacementNamed(context, '/confirmarCita', arguments: {
                  'direccion': _datos['direccion'],
                  'latlong' : _datos['latlong'],
                  'autoChico': _datos['autoChico'],
                  'soloLauto': _datos['soloLauto'],
                  'camioChica': _datos['camioChica'],
                  'soloLcamio': _datos['soloLcamio'],
                  'motos': _datos['motos'],
                  'hora': _hora.format(context).toString(),
                  'fecha': convertedDate,
                  'lavador': _currentLavador,
                  'telefono': telefonoCliente,
                  'notas': notas
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
                height: 55,
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),

                child: RaisedButton(
                  elevation: 3.0,
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: (){

                    showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now()
                    ).then((hora){
                      setState(() {
                        _hora = hora;
                      });
                    });

                  },
                  child: Row(
                  children: <Widget>[
                     Icon(Icons.access_time, color: Colors.white),
                      SizedBox(width: 10),
                     Text( _hora == null? "Elegir hora": _hora.format(context),
                             style: estiloBlanco),
                   ],
                  ),
                ),
              ),

              Container(
                height: 55,
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: RaisedButton(
                  elevation: 3.0,
                  color: azulFretum,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.calendar_today, color: Colors.white),
                      SizedBox(width: 10),
                      Text( _dateTime == null? "Elegir fecha": convertedDate,
                          style: estiloBlanco),
                    ],
                  ),
                  onPressed: (){
                    showDatePicker(
                      locale: Locale("es","MX"),
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030,)).then((date){
                      setState(() {
                        _dateTime = date;
                        convertedDate = new DateFormat("yyyy-MM-dd").format(_dateTime);
                      });
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Asigna un Lavador",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.motorcycle),
                  ),
                  value: _currentLavador??'Joaquín Mercado',
                  items: Lavadores.map((lavador){
                    return DropdownMenuItem(
                      value: lavador,
                      child: Text("$lavador",
                          style: TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentLavador = val),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone, color: Colors.grey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: "Teléfono del cliente"
                  ),
                  onChanged: (val) {
                    setState(() => telefonoCliente = val);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.note, color: Colors.grey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: "¿Algo mas que se necesite saber?"
                  ),
                  onChanged: (val) {
                    setState(() => notas = val);
                  },
                  textInputAction: TextInputAction.done,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
