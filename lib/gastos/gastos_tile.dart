import 'package:flutter/material.dart';
import 'package:fretummaster/colors.dart';
import 'package:fretummaster/gastos/gastos_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GastosTile extends StatelessWidget {

  final GastosModel gasto;
  GastosTile({this.gasto});
  final db = Firestore.instance;

  FToast fToast;

  Widget _toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.red,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.delete_forever, color: Colors.white),
        SizedBox(
          width: 12.0,
        ),
        Text("Gasto borrado", style: TextStyle(fontSize: 14, color: Colors.white),),
      ],
    ),
  );

  _showToast() {
    fToast.showToast(
      child: _toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {

    fToast = FToast(context);

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
          title: Row(
            children: <Widget>[
              Text("${gasto.nombre}"),
              Text("${gasto.id}", style: TextStyle(fontSize: 1, color: Colors.transparent),)
            ],
          ),
          subtitle: Text("${gasto.descripcion}, \n \$ ${gasto.monto},   ${gasto.metodo},   ${gasto.fecha}, \n ${gasto.lugar}"),
          isThreeLine: true,
          trailing: IconButton(
            icon: Icon(Icons.delete_forever),

            //borrar gasto
            onPressed: (){
              showDialog(context: context,
                  builder: (_dialogContext) => AlertDialog(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.delete_forever),
                        Text("  Borrar gasto", style: estiloNegro,),
                      ],
                    ),
                    content: Text("¿Estás seguro de borrar este gasto? \n Esta acción es irreversible", style: estiloGris,),
                    actions: <Widget>[
                      FlatButton(child: Text("Cancelar"),
                        onPressed: (){
                          Navigator.pop(_dialogContext);
                        },),
                      FlatButton(child: Text("Si"),
                        onPressed: ()async{
                        await db.collection("gastos").document(gasto.id).delete();
                        Navigator.pop(_dialogContext);
                        _showToast();
                        },)
                    ],
                    elevation: 20.0,
                    backgroundColor: Colors.grey[100],
                  ),
                  barrierDismissible: true);

            },
          ),
        ),
      ),
    );
  }
}
