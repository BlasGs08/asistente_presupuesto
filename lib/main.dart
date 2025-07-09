import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pantalla_login.dart';
import 'pantalla_entrada.dart';
import 'home_screen.dart'; 
import 'providers/carrito_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppPresupuesto());
}

class AppPresupuesto extends StatelessWidget {
  const AppPresupuesto({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CarritoProvider(),
      child: MaterialApp(
        title: 'Asistente de Presupuesto',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: PantallaLogin(), // Aquí empieza con login
      ),
    );
  }
}

