import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/pedidos.dart';

class ItemListaPedidos extends StatefulWidget {
  final Pedido pedido;

  ItemListaPedidos(this.pedido);

  @override
  _ItemListaPedidosState createState() => _ItemListaPedidosState();
}

class _ItemListaPedidosState extends State<ItemListaPedidos> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.pedido.monto.toStringAsFixed(0)}'),
            subtitle: Text(
                DateFormat('dd-MM-yyyy hh:mm').format(widget.pedido.fecha)),
            trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                }),
          ),
          //////////// si expanded es true agrego este widget, si es falso no agrega nada.
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              height: min(
                widget.pedido.productos.length * 23.0 + 10,
                100,
              ),
              child: ListView.builder(
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.pedido.productos[index].titulo,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '${widget.pedido.productos[index].cantidad}x \$${widget.pedido.productos[index].precio.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                itemCount: widget.pedido.productos.length,
              ),
            ),
        ],
      ),
    );
  }
}
