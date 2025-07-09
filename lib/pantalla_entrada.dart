import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'main.dart';


class PantallaEntrada extends StatefulWidget {
  @override
  _PantallaEntradaState createState() => _PantallaEntradaState();
}

class _PantallaEntradaState extends State<PantallaEntrada> {
  final _controladorPresupuesto = TextEditingController();
  final _controladorAhorro = TextEditingController();

  @override
  void dispose() {
    _controladorPresupuesto.dispose();
    _controladorAhorro.dispose();
    super.dispose();
  }

void _irAPrincipal() {
  final double? presupuesto = double.tryParse(_controladorPresupuesto.text);
  final double? ahorro = double.tryParse(_controladorAhorro.text);

  if (presupuesto == null || presupuesto <= 0 || ahorro == null || ahorro < 0 || ahorro > 100) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Por favor, ingresa valores válidos.')),
    );
    return;
  }

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => HomeScreen(
      presupuestoTotal: presupuesto,
      porcentajeAhorro: ahorro / 100,
    ),
  ),
);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración de Presupuesto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controladorPresupuesto,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: '¿Cuánto dinero tienes?'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _controladorAhorro,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: '¿Qué porcentaje quieres ahorrar?'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _irAPrincipal,
              child: Text('Calcular presupuesto'),
            ),
          ],
        ),
      ),
    );
  }
}