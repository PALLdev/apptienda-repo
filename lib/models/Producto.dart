import 'package:flutter/foundation.dart';

class Producto {
  final String id;
  final String titulo;
  final String descripcion;
  final double precio;
  final String imagenUrl;
  bool esFavorito;

  Producto({
    @required this.id,
    @required this.titulo,
    @required this.descripcion,
    @required this.imagenUrl,
    @required this.precio,
    this.esFavorito = false,
  });
}
