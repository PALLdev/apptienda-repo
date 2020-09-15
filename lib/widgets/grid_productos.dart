import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/productos_provider.dart';
import './item_producto.dart';
import '../providers/Producto.dart';

class GridProductos extends StatelessWidget {
  final bool verSoloFavoritos;
  GridProductos(this.verSoloFavoritos);

  @override
  Widget build(BuildContext context) {
    ///////////////////////////////
    ///   Provider.of crea un listener que hace que el metodo build se vuelva a cargar
    ///   cada vez que un metodo del provider notifique que hubo cambios en la lista
    ///
    final datosProductos = Provider.of<ProductosProvider>(context);
    final listaProductos = verSoloFavoritos
        ? datosProductos.productosFavoritos
        : datosProductos.listaProductosProvider;

    return GridView.builder(
      itemCount: listaProductos.length,
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4 / 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      //////////////////////////////////
      ///  Se usa .value para el rebuild de elementos que ya existen
      ///
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: listaProductos[index],
        child: ItemProducto(
            ///////////////// SIN PROVIDER /////////////////
            // id: listaProductos[index].id,
            // titulo: listaProductos[index].titulo,
            // urlImagen: listaProductos[index].imagenUrl,
            ),
      ),
    );
  }
}
