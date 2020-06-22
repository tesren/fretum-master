import 'package:flutter/material.dart';
import 'package:fretummaster/citas.dart';
import 'package:fretummaster/config.dart';
import 'package:fretummaster/gastos.dart';
import 'package:fretummaster/ingresos.dart';
import 'package:fretummaster/olvide_contra.dart';
import 'loading.dart';
import 'login.dart';
import 'package:fretummaster/perfil.dart';

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

    }
));

