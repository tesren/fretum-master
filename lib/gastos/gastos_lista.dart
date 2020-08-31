import 'package:flutter/material.dart';
import 'package:fretummaster/colors.dart';
import 'package:fretummaster/gastos/gastos_model.dart';
import 'package:provider/provider.dart';
import 'gastos_tile.dart';

class GastosLista extends StatefulWidget {
  @override
  _GastosListaState createState() => _GastosListaState();
}

class _GastosListaState extends State<GastosLista> {
  @override
  Widget build(BuildContext context) {

    final gastos = Provider.of<List<GastosModel>>(context) ?? [];

    return Container(
        padding: EdgeInsets.fromLTRB(5,5,5,5),
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: gastos.length,
          itemBuilder: (context, index) {
            return GastosTile(gasto: gastos[index]);
          },)
    );
  }
}
