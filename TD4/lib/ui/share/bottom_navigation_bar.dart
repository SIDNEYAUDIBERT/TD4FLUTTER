import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:jpp/models/cart.dart';
import 'package:provider/src/provider.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int indexSelected;

  const BottomNavigationBarWidget(this.indexSelected, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Cart cart = context.watch<Cart>();
    int _totalItems = cart.totalItemsWithQuantity;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: indexSelected,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_shopping_cart_outlined),
          label: 'Commande',
        ),
        BottomNavigationBarItem(
          icon: _totalItems == 0
              ? Icon(Icons.shopping_cart_outlined)
              : Badge(
                  child: Icon(Icons.shopping_cart),
                  position: BadgePosition.topEnd(),
                  badgeColor: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  badgeContent: Text(
                    _totalItems.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
            animationType: BadgeAnimationType.scale,
                ),
          label: 'Panier',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
      onTap: (index) {
        String page = '/';
        switch (index) {
          case 2:
            page = '/panier';
            break;
          case 3:
            page = '/profil';
            break;
        }
        Navigator.pushNamed(context, page);
      },
    );
  }
}
