import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/overview_productos_screen.dart';
import './screens/detalle_producto_screen.dart';
import './providers/productos_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///////////////////////
    ///  changenotifierprovider otorga una clase oculta a los widgets para que cuando esta cambia,
    ///  actualizar solo los child(widgets) con un listener activo a esa clase oculta
    ///
    ///
    return ChangeNotifierProvider(
      create: (ctx) => ProductosProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tienda Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Anton',
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (ctx) => OverviewProductosScreen(),
          DetalleProductoScreen.routeName: (ctx) => DetalleProductoScreen(),
        },
      ),
    );
  }
}
