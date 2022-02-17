import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jpp/models/cart.dart';
import 'package:jpp/ui/share/bottom_navigation_bar.dart';
import 'package:jpp/ui/share/pizzeria_style.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class Panier extends StatefulWidget {
  const Panier({Key? key}) : super(key: key);

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Panier'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _CartList(),
            ),
          ),
          _CartTotal(),
          Container(
              child: ElevatedButton(
            child: Text('Valider'),
            onPressed: () {
              print('Valider');
            },
          )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(2),
    );
  }
}

class _CartList extends StatefulWidget {
  const _CartList({Key? key}) : super(key: key);

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<_CartList> {
  @override
  Widget build(BuildContext context) {
    Cart _cart = context.watch<Cart>();
    return ListView.builder(
      itemExtent: 180,
      itemCount: _cart.totalItems,
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        return _buildItem(_cart, _cart.getCartItem(index));
      },
    );
  }

  Widget _buildItem(Cart cart, CartItem cartItem) {
    final NumberFormat format = NumberFormat("###.00 €");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/pizza/${cartItem.pizza.image}',
          height: 150,
          width: 150,
          fit: BoxFit.fill,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(cartItem.pizza.title +
                    ' x ' +
                    cartItem.pizza.quantity.toString()),
              ),
              Container(
                padding: const EdgeInsets.all(4.0),
                child: Text((cartItem.pizza.price * cartItem.pizza.quantity)
                    .toString()),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        cart.removeQuantity(cartItem.pizza);
                        setState(() {

                        });
                      },
                      icon: Icon(Icons.remove)),
                  IconButton(
                      onPressed: () {
                        cart.addQuantity(cartItem.pizza);
                        setState(() {

                        });
                      },
                      icon: Icon(Icons.add))
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _CartTotal extends StatelessWidget {
  //var format = NumberFormat("###.00 €");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      height: 220,
      child: Consumer<Cart>(builder: (context, cart, child) {
        if (cart.price <= 0) {
          return Center(
            child:
                Text('Aucun produit', style: PizzeriaStyle.priceTotalTextStyle),
          );
        } else {
          return Column(
            children: [
              Text('Total : ${cart.price} €'),
            ],
          );
        }
      }),
    );
  }
}
