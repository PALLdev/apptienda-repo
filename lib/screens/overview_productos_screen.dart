import 'package:flutter/material.dart';
import '../widgets/grid_productos.dart';
import '../widgets/drawer.dart';

class OverviewProductosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Del mas alla',
          style: Theme.of(context).textTheme.title,
        ),
      ),
      drawer: DrawerPersonalizado(),
      body: GridProductos(),
    );
  }
}
