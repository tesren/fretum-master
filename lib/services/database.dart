import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fretummaster/services/user_model.dart';

class DatabaseService {

  //usuarios
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection = Firestore.instance.collection("users");


  Future updateUserData(String nombre, String apellidos, int telefono, String correo) async {

    return await usersCollection.document(uid).setData({
      'nombre': nombre,
      'apellidos': apellidos,
      'telefono': telefono,
      'correo': correo,
    });
  }
  //lista de usuarios
 /* List<Usuarios> _listaUsuariosSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Usuarios(
        nombre: doc.data['nombre'] ?? '',
        apellidos: doc.data['apellidos'] ?? '',
        telefono: doc.data['telefono'] ?? 0,
      );
    }).toList();
  }*/

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

 /* Stream<List<Usuarios>> get users{
    return usersCollection.snapshots().map(_listaUsuariosSnapshot);
  }*/
  // get user doc stream
  Stream<UserData> get userData {
    return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }






}