import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fretummaster/gastos/gastos_model.dart';
import 'package:fretummaster/services/user_model.dart';
import 'package:fretummaster/citas/citas_model.dart';

class DatabaseService {

  //usuarios
  final String uid;
  DatabaseService({this.uid});

  //referencias
  final CollectionReference usersCollection = Firestore.instance.collection("users");
  final CollectionReference citasCollection = Firestore.instance.collection("citas");
  final CollectionReference gastosCollection = Firestore.instance.collection("gastos");

//no usado CREO
  Future updateUserData(String nombre, String apellidos, String telefono, String correo) async {
    return await usersCollection.document(uid).setData({
      'nombre': nombre,
      'apellidos': apellidos,
      'telefono': telefono,
      'correo': correo,
    });
  }



  //lista de citas
  List<CitasModel> _listaCitasSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return CitasModel(
        id: doc.documentID,
        fecha: doc.data['fecha'] ?? '',
        hora: doc.data['hora'] ?? '',
        direccion: doc.data['direccion'] ?? '',
        tiempoEstimado: doc.data['tiempo']?? '',
        total: doc.data['total'] ?? '',
        latlong: doc.data['LatLong'] ?? '',
        autoChico: doc.data['autoChico'] ?? '',
        camioChica: doc.data['camioChica'] ?? '',
        metodo: doc.data['metodo'] ?? '',
        motos: doc.data['motos'] ?? '',
        notas: doc.data['notas'] ?? '',
        telefono: doc.data['telefono'] ?? '',
        soloLcamioChica: doc.data['soloLCamioChica'] ?? '',
        soloLchico: doc.data['soloLChico'] ?? '',
      );
    }).toList();
  }


  //lista de gastos
  List<GastosModel> _listaGastosSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return GastosModel(
        id: doc.documentID,
        nombre: doc.data['nombre'] ?? '',
        descripcion: doc.data['descripcion'] ?? '',
        lugar: doc.data['lugar'] ?? '',
        fecha: doc.data['fecha'] ?? '',
        monto: doc.data['monto'] ?? '',
        metodo: doc.data['metodo'] ?? '',
      );
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        nombre: snapshot.data['nombre'],
        apellidos: snapshot.data['apellidos'],
        telefono: snapshot.data['telefono'],
        correo: snapshot.data['correo'],
    );
  }

  //Stream de citas
  Stream<List<CitasModel>> get citas{
    return citasCollection.snapshots().map(_listaCitasSnapshot);
  }

  //Stream de gastos
  Stream<List<GastosModel>> get gastos{
    return gastosCollection.snapshots().map(_listaGastosSnapshot);
  }


  // get user doc stream
  Stream<UserData> get userData {
    return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }






}