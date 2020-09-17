import 'package:flutter/foundation.dart';

class ArticuloCarro {
  final String id;
  final String titulo;
  final int cantidad;
  final double precio;

  ArticuloCarro({
    @required this.id,
    @required this.titulo,
    @required this.cantidad,
    @required this.precio,
  });
}

class Carro with ChangeNotifier {
  Map<String, ArticuloCarro> _listaProductosEnCarro = {};

  Map<String, ArticuloCarro> get productosEnCarro {
    return {..._listaProductosEnCarro};
  }

  int get contarArticulosCarro {
    return _listaProductosEnCarro.length;
  }

  double get totalCompra {
    var total = 0.0;
    _listaProductosEnCarro.forEach((key, artEnCarro) {
      total += artEnCarro.precio * artEnCarro.cantidad;
    });
    return total;
  }

  void addArticuloAlCarro(String id, String titulo, double precio) {
    if (_listaProductosEnCarro.containsKey(id)) {
      /// si ya existe agrego a la cantidad
      _listaProductosEnCarro.update(
        id,
        (existingArticulo) => ArticuloCarro(
          id: existingArticulo.id,
          titulo: existingArticulo.titulo,
          cantidad: existingArticulo.cantidad + 1,
          precio: existingArticulo.precio,
        ),
      );
    } else {
      /// si no existe lo agrego al carro
      _listaProductosEnCarro.putIfAbsent(
        id,
        () => ArticuloCarro(
          id: id,
          titulo: titulo,
          cantidad: 1,
          precio: precio,
        ),
      );
    }
    notifyListeners();
  }

  void borrarArticulo(String id) {
    _listaProductosEnCarro.remove(id);
    notifyListeners();
  }

  void vaciarCarro() {
    _listaProductosEnCarro = {};
    notifyListeners();
  }
}
