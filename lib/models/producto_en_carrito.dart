class ProductoEnCarrito {
  final String id;
  final String nombre;
  final double precio;
  int cantidad;

  ProductoEnCarrito({
    required this.id,
    required this.nombre,
    required this.precio,
    this.cantidad = 1,
  });

  double get total => precio * cantidad;

  Map<String, dynamic> toMap() => {
        'id': id,
        'nombre': nombre,
        'precioUnitario': precio,
        'cantidad': cantidad,
      };

  factory ProductoEnCarrito.fromMap(Map<String, dynamic> map) => ProductoEnCarrito(
        id: map['id'],
        nombre: map['nombre'],
        precio: map['precioUnitario'],
        cantidad: map['cantidad'],
      );
}
