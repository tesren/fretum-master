import 'package:flutter/material.dart';
import 'package:fretummaster/colors.dart';
import 'package:fretummaster/gastos/gastos_model.dart';

class GastosTile extends StatelessWidget {

  final GastosModel gasto;
  GastosTile({this.gasto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(5, 3, 5, 0),
        elevation: 4,
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("assets/baseline_money_off_black_48dp.png"),
            backgroundColor: Colors.grey[400],
          ),
          title: Text("${gasto.nombre}"),
          subtitle: Text("${gasto.descripcion}, \n \$ ${gasto.monto},   ${gasto.metodo},   ${gasto.fecha}, \n ${gasto.lugar}"),
          isThreeLine: true,
        ),
      ),
    );
  }
}
