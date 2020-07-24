import 'package:flutter/material.dart';
import 'package:fretummaster/agregar_gasto.dart';
import 'package:fretummaster/cambiar_contra.dart';
import 'package:fretummaster/cambiar_nombre.dart';
import 'package:fretummaster/citas.dart';
import 'package:fretummaster/services/auth.dart';
import 'package:fretummaster/services/user.dart';
import 'package:provider/provider.dart';
import 'config.dart';
import 'package:fretummaster/gastos.dart';
import 'package:fretummaster/ingresos.dart';
import 'package:fretummaster/olvide_contra.dart';
import 'loading.dart';
import 'login.dart';
import 'terminos.dart';
import 'package:fretummaster/perfil.dart';
import 'agregar_cita.dart';
import 'cambiar_nombre.dart';
import 'cambiar_apellidos.dart';
import 'reportar.dart';
import 'agregar_carros.dart';
import 'fechayhora.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations.dart';
import 'confirmar_cita.dart';
import 'register.dart';

    void main() => runApp(MyApp());

    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return StreamProvider<User>.value(
          value: AuthService().user,
          child: MaterialApp(
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
              '/agregarCarros': (context) => AgregarCarros(),

              '/fechayhora': (context) => FechayHora(),
              '/confirmarCita': (context)=> ConfirmarCita(),
              '/register': (context)=> Register(),
            },

            supportedLocales: [
              Locale('en', 'US'),
              Locale('es', 'MX'),
            ],
// These delegates make sure that the localization data for the proper language is loaded
            localizationsDelegates: [
// THIS CLASS WILL BE ADDED LATER
// A class which loads the translations from JSON files
              AppLocalizations.delegate,
// Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
// Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
            ],
// Returns a locale which will be used by the app
            localeResolutionCallback: (locale, supportedLocales) {
// Check if the current device locale is supported
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
// If the locale of the device is not supported, use the first one
// from the list (English, in this case).
              return supportedLocales.first;
            },

          ),
        );
      }
    }


















