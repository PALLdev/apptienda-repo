import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/detalle_producto_screen.dart';
import '../providers/Producto.dart';
import '../providers/carro.dart';

class ItemProducto extends StatelessWidget {
  // final String id;
  // final String titulo;
  // final String urlImagen;

  // ItemProducto({this.id, this.titulo, this.urlImagen});

  @override
  Widget build(BuildContext context) {
    final listenerProducto = Provider.of<Producto>(context, listen: false);
    final listenerCarro = Provider.of<Carro>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              DetalleProductoScreen.routeName,
              arguments: listenerProducto.id,
            );
          },
          child: Image.network(
            listenerProducto.imagenUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          ////////////////
          ///  Se usa consumer para el rebuild de los widgets que sean necesarios
          ///
          leading: Consumer<Producto>(
            builder: (context, value, _) => IconButton(
              icon: Icon(
                listenerProducto.esFavorito
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                listenerProducto.toggleEstadoFavorito();
              },
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              listenerCarro.addArticuloAlCarro(listenerProducto.id,
                  listenerProducto.titulo, listenerProducto.precio);
              //////////////////
              ///  Scafolf.of(context) accede a una conexion con el primer scafold() que encuentre sobre el
              ///  y accede a propiedades que controlan la pagina completa
              ///  en este caso el scafold de overview_productos_screen
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Agregado al carro!',
                    // textAlign: TextAlign.center,
                  ),
                  backgroundColor: Theme.of(context).primaryColorDark,
                  duration: Duration(seconds: 1),
                  /////// para el UNDO debo quitar el producto
                  ///     de la lista de articulos en el carro
                  action: SnackBarAction(
                      label: 'Deshacer',
                      onPressed: () {
                        listenerCarro
                            .eliminarSingleArticulo(listenerProducto.id);
                      }),
                ),
              );
            },
          ),
          backgroundColor: Colors.black54,
          title: Text(
            listenerProducto.titulo,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
