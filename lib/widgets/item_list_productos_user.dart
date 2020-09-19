import 'package:flutter/material.dart';

class ItemListProductosUser extends StatelessWidget {
  final String titulo;
  final String imgUrl;

  ItemListProductosUser(
    this.titulo,
    this.imgUrl,
  );
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      title: Text(titulo),
      trailing: Container(
        width: 96,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
