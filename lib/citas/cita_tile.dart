import 'package:flutter/material.dart';
import '../colors.dart';
import 'citas_model.dart';


class CitasTile extends StatelessWidget {

  final CitasModel cita;
  CitasTile({this.cita});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
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
          Text("MXN\$${cita.total}",style: estiloNegro),
          Text("ID: ${cita.id}"),
        ],
      ),
    );
  }
}
