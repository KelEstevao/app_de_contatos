import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_de_contatos/telas/cadastro.dart';
import 'package:app_de_contatos/telas/contatos.dart';
import 'package:app_de_contatos/telas/esq_senha.dart';
import 'package:app_de_contatos/telas/extra1.dart';
import 'package:app_de_contatos/telas/extra2.dart';
import 'package:app_de_contatos/telas/login.dart';
import 'package:app_de_contatos/telas/maps.dart';
import 'package:app_de_contatos/telas/menu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      title: 'home',
      initialRoute: '/login',
      routes: {
        '/login': (context) => MyHome(),
        '/menu': (context) => Menu(),
        '/maps': (context) => Maps(),
        '/cadastro': (context) => Cadastro(),
        '/extra1': (context) => Extra1(),
        '/contatos': (context) => Contatos(),
        '/extra2': (context) => Extra2(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
