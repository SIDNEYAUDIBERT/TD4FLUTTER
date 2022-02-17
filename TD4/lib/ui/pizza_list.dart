import 'package:flutter/material.dart';
import 'package:jpp/models/cart.dart';
import 'package:jpp/models/pizza.dart';
import 'package:jpp/models/pizza_data.dart';
import 'package:jpp/ui/share/appbar_widget.dart';
import 'package:jpp/ui/share/bottom_navigation_bar.dart';
import 'pizza_details.dart';
import 'share/buy_button_widget.dart';

class PizzaList extends StatefulWidget {
  final Cart _cart;

  const PizzaList(this._cart, {Key? key}) : super(key: key);

  @override
  _PizzaListState createState() => _PizzaListState();
}

class _PizzaListState extends State<PizzaList> {
  // La liste des pizzas
  List<Pizza> _pizzas = [];

  @override
  void initState() {
    _pizzas = PizzaData.buildList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget("Nos pizzas", widget._cart),
      body: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          //itemExtent: ,
          itemCount: _pizzas.length,
          itemBuilder: (context, index) {
            return _buildRow(context, _pizzas[index]);
          }),
      bottomNavigationBar: BottomNavigationBarWidget(0),
    );
  }

  _buildRow(context, Pizza pizza) {
    return Card(
      //color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10.0), top: Radius.circular(2.0)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PizzaDetails(pizza, widget._cart),
                ),
              );
            },
            child: _buildPizzaDetails(context, pizza),
          ),
          BuyButtonWidget(pizza),
        ],
      ),
    );
  }

  _buildPizzaDetails(BuildContext context, Pizza pizza) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(pizza.title),
          subtitle: Text(pizza.garniture),
          leading: Icon(Icons.local_pizza),
        ),
        Image.asset('assets/images/pizza/${pizza.image}',
            height: 200, fit: BoxFit.fill),
        Container(
          padding: const EdgeInsets.all(4.0),
          child: Text(pizza.garniture),
        ),
      ],
    );
  }
}
