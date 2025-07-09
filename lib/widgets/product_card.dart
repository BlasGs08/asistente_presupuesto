import 'package:flutter/material.dart';
import '../models/producto.dart';

class ProductCard extends StatelessWidget {
  final Producto producto;
  final VoidCallback onProductoAgregado;

  const ProductCard({
    Key? key,
    required this.producto,
    required this.onProductoAgregado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.shopping_basket_outlined, color: Colors.blueAccent),
        title: Text(producto.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Precio: \$${producto.precio.toStringAsFixed(2)}'),
        trailing: ElevatedButton.icon(
          icon: const Icon(Icons.add_shopping_cart),
          label: const Text('Agregar'),
          onPressed: onProductoAgregado,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
