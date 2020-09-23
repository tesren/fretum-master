import 'package:flutter/material.dart';
import '../colors.dart';
import 'citas_model.dart';


class CitasTile extends StatelessWidget {

  final CitasModel cita;
  CitasTile({this.cita});



  @override
  Widget build(BuildContext context) {

    String idCita = cita.id;

    return Card(
      elevation: 4,
      child: InkWell(
        onTap: (){
          Navigator.pushReplacementNamed(context, '/detallesCita', arguments: { 'id': idCita });
        },
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.calendar_today, color: Colors.black),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Align(alignment: Alignment.centerLeft,
                      child: Container(child: Text("${cita.fecha}, ${cita.hora}", style: estiloNegro,))),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.location_on, color: Colors.grey),
                Expanded(child: Text("${cita.direccion}", style: estiloGris, maxLines: 3, overflow: TextOverflow.fade))
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.timer, color: Colors.grey),
                Text("${cita.tiempoEstimado} horas aprox", style: estiloGris),
              ],
            ),
            Text("Total", style: estiloAzul,),
            Text("MXN\$${cita.total}",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
            Text("ID: ${cita.id}" , style: TextStyle(fontSize: 2, color: Colors.transparent)),
          ],
        ),
      ),
    );
  }
}
