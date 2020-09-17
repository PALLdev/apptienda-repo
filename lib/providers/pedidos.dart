import 'package:flutter/foundation.dart';
import './carro.dart';

class Pedido {
  final String id;
  final double monto;
  final List<ArticuloCarro> productos;
  final DateTime fecha;

  Pedido({
    @required this.id,
    @required this.productos,
    @required this.monto,
    @required this.fecha,
  });
}

class PedidosProvider with ChangeNotifier {
  List<Pedido> _pedidos = [];

  List<Pedido> get pedidos {
    return [..._pedidos];
  }

  void addPedido(List<ArticuloCarro> productosEnCarro, double total) {
    _pedidos.insert(
        0,
        Pedido(
            id: DateTime.now().toString(),
            productos: productosEnCarro,
            monto: total,
            fecha: DateTime.now()));
    notifyListeners();
  }
}
