import 'package:flutter/material.dart';
import 'package:fretummaster/citas.dart';
import 'package:fretummaster/olvide_contra.dart';
import 'loading.dart';
import 'login.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/login': (context) => Login(),
      '/citas': (context) => Citas(),
      '/olvide_contra': (context) => Olvide_contra(),
    }
));

