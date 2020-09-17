import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/overview_productos_screen.dart';
import './screens/detalle_producto_screen.dart';
import './providers/productos_provider.dart';
import './providers/carro.dart';
import './screens/carro_screen.dart';
import './providers/pedidos.dart';
import './screens/pedidos_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///////////////////////
    ///  changenotifierprovider otorga una clase oculta a los widgets para que cuando esta cambia,
    ///  actualizar solo los child(widgets) con un listener activo a esa clase oculta
    ///   No usamos .value ya que necesitamos instanciar objetos de producto, por lo que
    ///   es mejor utilizar el metodo create y no el value que pide changenotifierprovider  .value
    ///
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductosProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Carro(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PedidosProvider(),
        ),
      ],
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
          CarroScreen.routeName: (ctx) => CarroScreen(),
          PedidosScreen.routeName: (ctx) => PedidosScreen(),
        },
      ),
    );
  }
}
