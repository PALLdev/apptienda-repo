import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/pedidos.dart';

class ItemListaPedidos extends StatelessWidget {
  final Pedido pedido;

  ItemListaPedidos(this.pedido);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: Column(
        children: [
          ListTile(
            title: Text('\$${pedido.monto.toStringAsFixed(0)}'),
            subtitle: Text(DateFormat('dd MM yyyy hh:mm').format(pedido.fecha)),
            trailing:
                IconButton(icon: Icon(Icons.expand_more), onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
