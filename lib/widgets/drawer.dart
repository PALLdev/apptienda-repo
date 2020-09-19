import 'package:flutter/material.dart';
import '../screens/pedidos_screen.dart';

class DrawerPersonalizado extends StatelessWidget {
  Widget buildOpcionDrawer(
      BuildContext ctx, IconData icono, String texto, String route) {
    return ListTile(
      leading: Icon(
        icono,
        color: Colors.black87,
        size: 27,
      ),
      title: Text(
        texto,
        style: TextStyle(
          fontSize: 19,
          fontFamily: 'Anton',
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.of(ctx).pushReplacementNamed(route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Bienvenido'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          buildOpcionDrawer(context, Icons.shop, 'Tienda', '/'),
          buildOpcionDrawer(
              context, Icons.payment, 'Mis pedidos', PedidosScreen.routeName)
        ],
      ),
    );
  }
}
