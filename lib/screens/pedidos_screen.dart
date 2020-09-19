import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pedidos.dart';
import '../widgets/item_lista_Pedidos.dart';
import '../widgets/drawer.dart';

class PedidosScreen extends StatelessWidget {
  static const routeName = '/pedidos';
  @override
  Widget build(BuildContext context) {
    final listenerPedidos = Provider.of<PedidosProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tus pedidos'),
      ),
      drawer: DrawerPersonalizado(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => ItemListaPedidos(listenerPedidos.pedidos[i]),
        itemCount: listenerPedidos.pedidos.length,
      ),
    );
  }
}
