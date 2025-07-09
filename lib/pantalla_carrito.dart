import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/carrito_provider.dart';
import '../models/producto_en_carrito.dart';

class PantallaCarrito extends StatelessWidget {
  const PantallaCarrito({super.key});

  @override
  Widget build(BuildContext context) {
    final carrito = Provider.of<CarritoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: carrito.productos.isEmpty
          ? const Center(child: Text('El carrito está vacío'))
          : ListView.builder(
              itemCount: carrito.productos.length,
              itemBuilder: (context, index) {
                final producto = carrito.productos[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    title: Text(producto.nombre),
                    subtitle: Text('Precio unitario: \$${producto.precio.toStringAsFixed(2)}'),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                carrito.disminuirCantidad(producto.id);
                              },
                            ),
                            Text('${producto.cantidad}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                carrito.incrementarCantidad(producto.id);
                              },
                            ),
                          ],
                        ),
                        Text('Subtotal: \$${producto.total.toStringAsFixed(2)}'),
                      ],
                    ),
                    onLongPress: () {
                      carrito.eliminarProducto(producto.id);
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.teal.shade50,
        child: Text(
          'Total: \$${carrito.total.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}