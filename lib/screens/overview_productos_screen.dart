import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/grid_productos.dart';
import '../widgets/drawer.dart';
import '../providers/productos_provider.dart';
import '../widgets/badge.dart';
import '../providers/carro.dart';
import '../screens/carro_screen.dart';

enum OpcionesFiltroGrid {
  Favoritos,
  Todos,
}

class OverviewProductosScreen extends StatefulWidget {
  @override
  _OverviewProductosScreenState createState() =>
      _OverviewProductosScreenState();
}

class _OverviewProductosScreenState extends State<OverviewProductosScreen> {
  var _mostrarFavoritosOnly = false;

  @override
  Widget build(BuildContext context) {
    final listenerCarro = Provider.of<Carro>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Solo favoritos'),
                value: OpcionesFiltroGrid.Favoritos,
              ),
              PopupMenuItem(
                child: Text('Mostrar todos'),
                value: OpcionesFiltroGrid.Todos,
              ),
            ],
            onSelected: (OpcionesFiltroGrid opcionElegida) {
              setState(() {
                if (opcionElegida == OpcionesFiltroGrid.Favoritos) {
                  _mostrarFavoritosOnly = true;
                } else {
                  _mostrarFavoritosOnly = false;
                }
              });
            },
          ),
          Consumer<Carro>(
            builder: (_, carro, ch) => Badge(
              child: ch,
              value: carro.contarArticulosCarro.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  CarroScreen.routeName,
                );
              },
            ),
          ),
        ],
        title: Text(
          'Del mas alla',
          style: Theme.of(context).textTheme.title,
        ),
      ),
      drawer: DrawerPersonalizado(),
      body: GridProductos(_mostrarFavoritosOnly),
    );
  }
}
