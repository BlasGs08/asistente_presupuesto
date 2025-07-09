import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/producto.dart';
import '../widgets/product_card.dart';
import 'pantalla_carrito.dart';
import 'providers/carrito_provider.dart';
import 'models/producto_en_carrito.dart';

class HomeScreen extends StatefulWidget {
  final double presupuestoTotal;
  final double porcentajeAhorro;

  const HomeScreen({
    Key? key,
    required this.presupuestoTotal,
    required this.porcentajeAhorro,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


@override
void initState() {
  super.initState();
  final carritoProvider = Provider.of<CarritoProvider>(context, listen: false);
  carritoProvider.inicializarPresupuesto(widget.presupuestoTotal, widget.porcentajeAhorro);
}

void _agregarProducto(Producto producto) {
  final carritoProvider = Provider.of<CarritoProvider>(context, listen: false);

  // Verifica el presupuesto usando el provider
  if (carritoProvider.presupuestoRestante >= producto.precio) {
    carritoProvider.agregarProducto(
      ProductoEnCarrito(
        id: producto.nombre, // o usa un id único si tienes
        nombre: producto.nombre,
        precio: producto.precio,
        cantidad: 1,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${producto.nombre} agregado.'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Presupuesto insuficiente.'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ),
    );
  }
}



@override
Widget build(BuildContext context) {
  final presupuestoRestante = Provider.of<CarritoProvider>(context).presupuestoRestante;

  return Scaffold(
    appBar: AppBar(
      title: const Text('Asistente de Presupuesto'),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PantallaCarrito()),
            );
          },
        ),
      ],
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Presupuesto Restante', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  Text(
                    '\$${presupuestoRestante.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  child: ElevatedButton.icon(
    onPressed: () {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('¿Actualizar precios?'),
          content: Text('Esto reiniciará tu presupuesto y vaciará el carrito. ¿Deseas continuar?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CarritoProvider>().actualizarPreciosSugerenciasYReiniciar();
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Los precios fueron actualizados y el presupuesto reiniciado.'),
                    backgroundColor: Colors.orange,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Confirmar'),
            ),
          ],
        ),
      );
    },
    icon: Icon(Icons.refresh),
    label: Text("Actualizar precios"),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
    ),
  ),
),

        const Text('Sugerencias para ti', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Expanded(
          child: ListView.builder(
            itemCount: Producto.sugerencias.length,
            itemBuilder: (context, index) {
              final producto = Producto.sugerencias[index];
              return ProductCard(
                producto: producto,
                onProductoAgregado: () => _agregarProducto(producto),
              );
            },
          ),
        ),
      ],
    ),
  );
}
}