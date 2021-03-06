import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/productos_provider.dart';

class DetalleProductoScreen extends StatelessWidget {
  static const routeName = '/detalle-producto';

  // final String tituloProducto;
  // DetalleProductoScreen({this.tituloProducto});

  @override
  Widget build(BuildContext context) {
    final idProductoSelected =
        ModalRoute.of(context).settings.arguments as String;
    ////////////////////////
    ///  le podemos pasar false al listener para desactivarlo si no es necesario que este
    ///  pendiente a cambios en la lista del provider y para que no se recargue este metodo build.
    ///  ya que en este widget solo necesito obtener datos y no qe se actualizen.
    ///  Se utiliza si quiero obtener datos desde el provider solo cuando el screen se carga.
    ///  en el grid por ej no se utiliza listen:false para que este pendiente a cambios en los datos del provider,
    ///  ya que queremos reconstruirla cada vez que se agregue un nuevo producto por ejemplo..
    final datosProductoSelected =
        Provider.of<ProductosProvider>(context, listen: false)
            .buscarPorId(idProductoSelected);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          datosProductoSelected.titulo,
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                datosProductoSelected.imagenUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${datosProductoSelected.precio.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Text(
                datosProductoSelected.descripcion,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
