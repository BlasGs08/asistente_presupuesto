class Producto {
  final String nombre;
  double precio;

  Producto({required this.nombre, required this.precio});

  static List<Producto> sugerencias = [
    Producto(nombre: 'Harina PAN', precio: 1.90),
    Producto(nombre: 'Arroz', precio: 2.30),
    Producto(nombre: 'Leche en polvo', precio: 5.00),
  ];
}