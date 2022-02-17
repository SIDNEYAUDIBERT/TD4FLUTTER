import 'package:flutter/material.dart';
import 'package:jpp/models/cart.dart';
import 'package:jpp/ui/share/total_widget.dart';

class Panier extends StatefulWidget {
  final Cart _cart;

  const Panier(this._cart, {Key? key}) : super(key: key);

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
            child: ListView.builder(
                itemExtent: 180,
                itemCount: widget._cart.totalItems(),
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (context, index) {
                  return _buildItem(widget._cart.getCartItem(index));
                }),
          ),
          Row(
            children: [
              Text('Total : ${widget._cart.price} €'),
            ],
          ),
          Container(
              child: ElevatedButton(
            child: Text('Valider'),
            onPressed: () {
              print('Valider');
            },
          )),
        ],
      ),
    );
  }

  Widget _buildItem(CartItem cartItem) {
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
                title:
                    Text(cartItem.pizza.title + ' x ${cartItem.pizza.quantity}'),
              ),
              Container(
                padding: const EdgeInsets.all(4.0),
                child:
                    Text('${cartItem.pizza.price * cartItem.pizza.quantity} €'),
              ),
              IconButton(
                  onPressed: () {
                    Widget okButton = TextButton(
                      child: Text("OK"),
                      onPressed: () {Navigator.of(context).pop(); },
                    );
                    AlertDialog alert = AlertDialog(
                      title: Text("Dommage..."),
                      content: Text('Pizza ${cartItem.pizza.title} supprimée du panier !'),
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
                    setState(widget._cart.removeProduct(cartItem.pizza));
                  },
                  icon: Icon(Icons.remove)),
              IconButton(
                  onPressed: () {
                    Widget okButton = TextButton(
                      child: Text("OK"),
                      onPressed: () {Navigator.of(context).pop(); },
                    );
                    AlertDialog alert = AlertDialog(
                      title: Text("Super !"),
                      content: Text('Pizza ${cartItem.pizza.title} ajoutée au panier !'),
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
                    setState(widget._cart.addProduct(cartItem.pizza));
                  },
                  icon: Icon(Icons.add)),
            ],
          ),
        ),
      ],
    );
  }
}
