import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/productos_provider.dart';
import '../widgets/item_list_productos_user.dart';
import '../widgets/drawer.dart';
import './add_producto_screen.dart';

class MantenedorProductosScreen extends StatelessWidget {
  static const routeName = '/productos-usuario';

  @override
  Widget build(BuildContext context) {
    final lsnrProductos = Provider.of<ProductosProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tus productos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.of(context).pushNamed(AddProductoScreen.routeName);
            },
          )
        ],
      ),
      drawer: DrawerPersonalizado(),
      body: ListView.builder(
        itemCount: lsnrProductos.listaProductosProvider.length,
        itemBuilder: (ctx, index) => Column(
          children: [
            ItemListProductosUser(
              lsnrProductos.listaProductosProvider[index].id,
              lsnrProductos.listaProductosProvider[index].titulo,
              lsnrProductos.listaProductosProvider[index].imagenUrl,
            ),
            Divider(
              color: Theme.of(ctx).primaryColorLight,
              thickness: 0.3,
              indent: 10,
              endIndent: 10,
            ),
          ],
        ),
      ),
    );
  }
}
