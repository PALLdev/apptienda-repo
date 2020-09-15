import 'package:flutter/material.dart';
import '../screens/detalle_producto_screen.dart';

class ItemProducto extends StatelessWidget {
  final String id;
  final String titulo;
  final String urlImagen;

  ItemProducto({this.id, this.titulo, this.urlImagen});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              DetalleProductoScreen.routeName,
              arguments: id,
            );
          },
          child: Image.network(
            urlImagen,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).accentColor,
            ),
            onPressed: null,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: null,
          ),
          backgroundColor: Colors.black54,
          title: Text(
            titulo,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
