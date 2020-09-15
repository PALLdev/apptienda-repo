import 'package:flutter/foundation.dart';

class Producto with ChangeNotifier {
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

  /////////////////////////////////////
  ///  si esFavorito es false con el signo ! pasa a ser su contrario osea true,
  ///  por lo que cambia de valor esFavorito
  ///
  void toggleEstadoFavorito() {
    esFavorito = !esFavorito;
    notifyListeners();
  }
}
