import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fretummaster/services/user_model.dart';
import 'package:fretummaster/services/citas_model.dart';

class DatabaseService {

  //usuarios
  final String uid;
  DatabaseService({this.uid});

  //referencias
  final CollectionReference usersCollection = Firestore.instance.collection("users");
  final CollectionReference citasCollection = Firestore.instance.collection("citas");

//no usado CREO
  Future updateUserData(String nombre, String apellidos, int telefono, String correo) async {
    return await usersCollection.document(uid).setData({
      'nombre': nombre,
      'apellidos': apellidos,
      'telefono': telefono,
      'correo': correo,
    });
  }



  //lista de citas
  List<Citas> _listaCitasSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Citas(
        id: doc.documentID,
        fecha: doc.data['fecha'] ?? '',
        hora: doc.data['hora'] ?? '',
        direccion: doc.data['direccion'] ?? '',
        tiempoEstimado: doc.data['tiempo']?? '',
        total: doc.data['total'] ?? ''
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
  Stream<List<Citas>> get citas{
    return citasCollection.snapshots().map(_listaCitasSnapshot);
  }


  // get user doc stream
  Stream<UserData> get userData {
    return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }






}