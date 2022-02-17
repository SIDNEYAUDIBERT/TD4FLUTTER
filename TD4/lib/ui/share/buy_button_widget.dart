import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jpp/models/cart.dart';
import 'package:jpp/models/pizza.dart';
import 'package:provider/provider.dart';

class BuyButtonWidget extends StatelessWidget {
  final Pizza _pizza;
  const BuyButtonWidget(this._pizza, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart _cart = Provider.of(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Colors.red.shade800)),
          child:Row(
            children: [
              Icon(Icons.shopping_cart),
              SizedBox(width: 5),
              Text("Commander"),
            ],
          ),
          onPressed: () {
            _cart.addProduct(_pizza);
            Widget okButton = TextButton(
              child: Text("OK"),
              onPressed: () {Navigator.of(context).pop(); },
            );
            AlertDialog alert = AlertDialog(
              title: Text("Super !"),
              content: Text('Pizza ${_pizza.title} ajoutée au panier !'),
              actions: [
                okButton,
              ],
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          }
        ),
      ],
    );
  }
}
