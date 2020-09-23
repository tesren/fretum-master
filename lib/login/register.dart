import 'package:flutter/material.dart';
import '../colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fretummaster/services/auth.dart';
import 'package:fretummaster/services/user.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _cNombre = TextEditingController();
  final _cApellidos = TextEditingController();
  final _cPhone = TextEditingController();
  final _cCorreo = TextEditingController();
  final _cContra = TextEditingController();
  final _cConfirm = TextEditingController();

  Color _colorCubo = Colors.transparent;

  String _email = '';
  String _contra = '';
  String _confirm = '';
  int telefono = 0;

  final AuthService _auth = AuthService();

  FToast fToast;

  Widget _toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.green,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle, color: Colors.white),
        SizedBox(
          width: 12.0,
        ),
        Text("Registro exitoso", style: TextStyle(fontSize: 14, color: Colors.white),),
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

    User user = Provider.of<User>(context);
    fToast = FToast(context);


    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushReplacementNamed(context, '/login');
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
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
              Text("Ingrese sus datos",
                  style: estiloBlanco),
            ],
          ),
          backgroundColor: azulFretum,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
              child: Column(
                children: <Widget>[

                  //nombre
                  TextField(
                    controller: _cNombre,
                    keyboardType: TextInputType.text,
                    maxLength: 35,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle, color: Colors.grey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: "Nombre"
                    ),
                    onChanged: (val) {
                     // setState(() => email = val);
                    },
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  ),
                  SizedBox(height: 15.0),

                  //apellidos
                  TextField(
                    controller: _cApellidos,
                    keyboardType: TextInputType.text,
                    maxLength: 60,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.font_download, color: Colors.grey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: "Apellidos"
                    ),
                    onChanged: (val) {
                      // setState(() => email = val);
                    },
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  ),
                  SizedBox(height: 15.0),

                  InternationalPhoneNumberInput(
                    ignoreBlank: false,
                    maxLength: 15,
                    countries: ['MX'],
                    autoValidate: false,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    textFieldController: _cPhone,
                    inputDecoration: InputDecoration(
                        prefixIcon: Icon(Icons.local_phone, color: Colors.grey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: "Teléfono",
                    ),
                  ),

                  //telefono
                /*  TextField(
                    controller: _cPhone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone, color: Colors.grey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: "Telefono"
                    ),
                    onChanged: (val) {
                       //setState(() => telefono = val);
                    },
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  ),*/
                  SizedBox(height: 15.0),

                  //correo
                  TextField(
                    controller: _cCorreo,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 60,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.grey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: "Correo"
                    ),
                    onChanged: (val) {
                       setState(() => _email = val);
                    },
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  ),
                  SizedBox(height: 15.0),

                  //contraseña
                  TextField(
                    controller: _cContra,
                    keyboardType: TextInputType.text,
                    maxLength: 30,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.grey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: "Contraseña"
                    ),
                    onChanged: (val) {
                       setState(() => _contra = val);
                    },
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  ),
                  SizedBox(height: 15.0),

                  //confirmar contraseña
                  TextField(
                    maxLength: 30,
                    controller: _cConfirm,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.grey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: "Confirmar contraseña"
                    ),
                    onChanged: (val) {
                       setState(() => _confirm = val);
                    },
                  ),
                  SizedBox(height: 15.0),

                  Container(
                    width: double.infinity,
                    height: 55,

                    //boton de registrarse
                    child: RaisedButton(
                      elevation: 5.0,
                      color: azulFretum,
                      onPressed: ()async{
                        if(_cNombre.text.isEmpty || _cApellidos.text.isEmpty || _cPhone.text.isEmpty || _cCorreo.text.isEmpty || _cContra.text.isEmpty || _cConfirm.text.isEmpty){
                          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Por favor llena los campos vacios')));
                        }if(_contra != _confirm){
                          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Las contraseñas no coinciden')));
                        }else{
                          setState(() {
                            _colorCubo = azulFretum;
                          });
                          dynamic result = await _auth.registerWithEmailAndPassword(_email, _contra, _cNombre.text.toString(), _cApellidos.text.toString(), _cPhone.text.toString());

                          if(result == null){
                            setState(() {
                              _colorCubo = Colors.transparent;
                            });
                            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Hubo un error, por favor intente mas tarde')));
                          }else{
                            //mostrar Toast personalizado
                            _showToast();
                            Navigator.pushReplacementNamed(context, '/login');
                          }

                        }
                      },
                      child: Text("Registrarse", style: estiloBlanco),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SpinKitFadingCube(
                    color: _colorCubo,
                    size: 30,
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
