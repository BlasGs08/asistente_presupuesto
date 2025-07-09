import 'package:asistente_presupuesto/models/producto.dart';
import 'package:flutter/material.dart';
import '../models/producto_en_carrito.dart';
import 'dart:math';


class CarritoProvider extends ChangeNotifier {
  final Map<String, ProductoEnCarrito> _carrito = {};

  Map<String, ProductoEnCarrito> get carrito => _carrito;

  // Getter para obtener una lista de productos
  List<ProductoEnCarrito> get productos => _carrito.values.toList();

  // Presupuesto y ahorro
  double _presupuestoInicial = 0;
  double _porcentajeAhorro = 0;

  void inicializarPresupuesto(double presupuesto, double porcentajeAhorro) {
    _presupuestoInicial = presupuesto;
    _porcentajeAhorro = porcentajeAhorro;
    notifyListeners();
  }

  double get presupuestoRestante {
    final ahorro = _presupuestoInicial * _porcentajeAhorro;
    final gastado = productos.fold(0.0, (suma, p) => suma + p.precio * p.cantidad);
    return _presupuestoInicial - ahorro - gastado;
  }

  double get total {
    double suma = 0;
    _carrito.forEach((_, producto) {
      suma += producto.precio * producto.cantidad;
    });
    return suma;
  }

  void agregarProducto(ProductoEnCarrito producto) {
    if (_carrito.containsKey(producto.id)) {
      _carrito[producto.id]!.cantidad += producto.cantidad;
    } else {
      _carrito[producto.id] = producto;
    }
    notifyListeners();
  }

  void eliminarProducto(String id) {
    _carrito.remove(id);
    notifyListeners();
  }

  void incrementarCantidad(String id) {
    if (_carrito.containsKey(id)) {
      _carrito[id]!.cantidad++;
      notifyListeners();
    }
  }

  void disminuirCantidad(String id) {
    if (_carrito.containsKey(id)) {
      if (_carrito[id]!.cantidad > 1) {
        _carrito[id]!.cantidad--;
      } else {
        _carrito.remove(id);
      }
      notifyListeners();
    }
  }

  void vaciarCarrito() {
    _carrito.clear();
    notifyListeners();
  }

void actualizarPreciosSugerenciasYReiniciar() {
  final random = Random();

  // Actualiza los precios de las sugerencias
  for (var producto in Producto.sugerencias) {
    final cambio = (random.nextDouble() * 0.2) - 0.1; // -10% a +10%
    final nuevoPrecio = (producto.precio * (1 + cambio)).clamp(0.1, double.infinity);
    producto.precio = double.parse(nuevoPrecio.toStringAsFixed(2));
  }

  // Vacía el carrito
  _carrito.clear();

  // No necesitas restablecer el presupuesto si usas _presupuestoInicial y _porcentajeAhorro,
  // porque presupuestoRestante se calcula automáticamente con esos valores y el carrito vacío.

  notifyListeners();
}
}


