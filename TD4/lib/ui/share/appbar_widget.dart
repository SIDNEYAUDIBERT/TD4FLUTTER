import 'package:flutter/material.dart';
import 'package:jpp/models/cart.dart';

import '../panier.dart';

class AppBarWidget
    extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Cart _cart;


  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  const AppBarWidget(this.title, this._cart, {Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Panier(),
              ));
          },
          icon: Icon(Icons.shopping_cart),
        )
      ],
    );
  }
}