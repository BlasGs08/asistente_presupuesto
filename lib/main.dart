import 'package:flutter/material.dart';
import 'pantalla_entrada.dart';

void main() => runApp(AppPresupuesto());

class AppPresupuesto extends StatelessWidget {
  const AppPresupuesto({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asistente de Presupuesto',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: PantallaEntrada(),
    );
  }
}

class PantallaInicio extends StatelessWidget {
  final double presupuestoTotal;
  final double porcentajeAhorro;

  const PantallaInicio({
    Key? key,
    required this.presupuestoTotal,
    required this.porcentajeAhorro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double montoAhorro = presupuestoTotal * porcentajeAhorro;
    double montoDisponible = presupuestoTotal - montoAhorro;

    return Scaffold(
      appBar: AppBar(title: Text('Asistente de Presupuesto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _tarjetaResumen(presupuestoTotal, montoAhorro),
            SizedBox(height: 20),
            Text('¿Qué puedo comprar hoy?', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Expanded(child: _listaSugerencias()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.list),
                  label: Text("Ver más sugerencias"),
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {},
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tarjetaResumen(double total, double ahorro) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(Icons.account_balance_wallet, size: 40),
        title: Text("Disponible: \$${(total - ahorro).toStringAsFixed(2)}"),
        subtitle: Text("Meta de ahorro: \$${ahorro.toStringAsFixed(2)}"),
      ),
    );
  }

  Widget _listaSugerencias() {
    final List<Map<String, dynamic>> productos = [
      {"nombre": "Harina PAN", "tienda": "Tienda X", "precio": 1.90},
      {"nombre": "Arroz", "tienda": "Supermercado Y", "precio": 2.30},
      {"nombre": "Leche en polvo", "tienda": "Tienda Z", "precio": 5.00},
    ];

    return ListView.builder(
      itemCount: productos.length,
      itemBuilder: (context, indice) {
        final Map<String, dynamic> producto = productos[indice];
        return Card(
          child: ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text(producto["nombre"] as String),
            subtitle: Text("${producto["tienda"] as String} - \$${producto["precio"]}"),
          ),
        );
      },
    );
  }
}
