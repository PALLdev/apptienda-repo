import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/carro.dart';
import '../widgets/item_lista_carro.dart';
import '../providers/pedidos.dart';

class CarroScreen extends StatelessWidget {
  static const routeName = '/carro';
  @override
  Widget build(BuildContext context) {
    final listenerCarro = Provider.of<Carro>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos en tu carro'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${listenerCarro.totalCompra.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<PedidosProvider>(context, listen: false)
                          .addPedido(
                              listenerCarro.productosEnCarro.values.toList(),
                              listenerCarro.totalCompra);
                      listenerCarro.vaciarCarro();
                    },
                    child: Text(
                      'HAZ TU PEDIDO!',
                    ),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) => ItemListaCarro(
              id: listenerCarro.productosEnCarro.values.toList()[i].id,
              //////////////// keys se refiere a las keys del Map productos
              idProducto: listenerCarro.productosEnCarro.keys.toList()[i],
              titulo: listenerCarro.productosEnCarro.values.toList()[i].titulo,
              cantidad:
                  listenerCarro.productosEnCarro.values.toList()[i].cantidad,
              precio: listenerCarro.productosEnCarro.values.toList()[i].precio,
            ),
            itemCount: listenerCarro.contarArticulosCarro,
          ))
        ],
      ),
    );
  }
}
