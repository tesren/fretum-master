import 'package:flutter/material.dart';
import 'package:fretummaster/agregar_gasto.dart';
import 'package:fretummaster/cambiar_contra.dart';
import 'package:fretummaster/cambiar_nombre.dart';
import 'package:fretummaster/citas.dart';
import 'package:fretummaster/config.dart';
import 'package:fretummaster/gastos.dart';
import 'package:fretummaster/ingresos.dart';
import 'package:fretummaster/olvide_contra.dart';
import 'package:fretummaster/terminos.dart';
import 'loading.dart';
import 'login.dart';
import 'package:fretummaster/perfil.dart';
import 'agregar_cita.dart';
import 'cambiar_nombre.dart';
import 'cambiar_apellidos.dart';
import 'reportar.dart';
import 'terminos.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/login': (context) => Login(),
      '/citas': (context) => Citas(),
      '/olvide_contra': (context) => Olvide_contra(),
      '/perfil': (context) => Perfil(),
          '/ingresos': (context) => Ingresos(),

      '/gastos': (context) => Gastos(),
      '/config': (context) => Config(),
      '/agregar_cita': (context) => Agregar_cita(),
      '/agregarGasto': (context) => AgregarGasto(),
          '/cambiarNombre': (context) => CambiarNombre(),

      '/cambiarApellidos': (context) => CambiarApellidos(),
      '/cambiarContra': (context) => CambiarContra(),
      '/reportar': (context) => Reportar(),
      '/terminos': (context) => Terminos(),

    }
));

