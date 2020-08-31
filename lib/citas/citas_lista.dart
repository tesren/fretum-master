import 'package:flutter/material.dart';
import '../colors.dart';
import 'package:provider/provider.dart';
import 'citas_model.dart';
import 'cita_tile.dart';

class CitasLista extends StatefulWidget {
  @override
  _CitasListaState createState() => _CitasListaState();
}

class _CitasListaState extends State<CitasLista> {
  @override
  Widget build(BuildContext context) {

    final citas = Provider.of<List<CitasModel>>(context) ?? [];

    return Container(
        padding: EdgeInsets.fromLTRB(5,5,5,5),
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: citas.length,
          itemBuilder: (context, index) {
            return CitasTile(cita: citas[index]);
          },)
    );
  }
}
