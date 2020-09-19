import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/carro.dart';

class ItemListaCarro extends StatelessWidget {
  final String id;
  final String idProducto;
  final String titulo;
  final double precio;
  final int cantidad;

  ItemListaCarro(
      {this.id, this.titulo, this.precio, this.cantidad, this.idProducto});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: FittedBox(child: Text('\$${precio.toStringAsFixed(0)}')),
              ),
            ),
            title: Text(titulo),
            subtitle:
                Text('Total: \$${(precio * cantidad).toStringAsFixed(0)}'),
            trailing: Text('${cantidad}x'),
          ),
        ),
      ),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete_sweep,
          size: 30,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Carro>(context, listen: false).borrarArticulo(idProducto);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              'Confirma la eliminación',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: Text(
                '¿Estas seguro de que deseas eliminar este producto de tu carro de compras?'),
            actions: [
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                textColor: Theme.of(context).errorColor,
                child: Text('Eliminar'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
