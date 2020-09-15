import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/productos_provider.dart';
import './item_producto.dart';

class GridProductos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///////////////////////////////
    ///   Provider.of crea un listener que hace que el metodo build se vuelva a cargar
    ///   cada vez que un metodo del provider notifique que hubo cambios en la lista
    ///
    final datosProductos = Provider.of<ProductosProvider>(context);
    final listaProductos = datosProductos.listaProductosProvider;

    return GridView.builder(
      itemCount: listaProductos.length,
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ItemProducto(
        id: listaProductos[index].id,
        titulo: listaProductos[index].titulo,
        urlImagen: listaProductos[index].imagenUrl,
      ),
    );
  }
}
