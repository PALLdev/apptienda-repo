import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/add_producto_screen.dart';
import '../providers/productos_provider.dart';

class ItemListProductosUser extends StatelessWidget {
  final String id;
  final String titulo;
  final String imgUrl;

  ItemListProductosUser(
    this.id,
    this.titulo,
    this.imgUrl,
  );
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      title: Text(titulo),
      trailing: Container(
        width: 96,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AddProductoScreen.routeName, arguments: id);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () {
                Provider.of<ProductosProvider>(context, listen: false)
                    .deleteProducto(id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
