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

  TimeOfDay _hora;

  final List<String> Lavadores =['Carlos Maldonado', 'Erick Pérez', 'Luis Monroy', 'Juan Gonzales'];
  String _currentLavador;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushReplacementNamed(context, '/agregarCarros');
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
            onPressed: () => Navigator.pushReplacementNamed(context, '/agregarCarros'),
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
                Navigator.pushReplacementNamed(context, '/');
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
                  value: _currentLavador??'Carlos Maldonado',
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
            ],
          ),
        ),
      ),
    );
  }
}
