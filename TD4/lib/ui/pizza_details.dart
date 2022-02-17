import 'package:flutter/material.dart';
import 'package:jpp/models/cart.dart';
import 'package:jpp/models/option_item.dart';
import 'package:jpp/models/pizza.dart';
import 'package:jpp/ui/share/appbar_widget.dart';
import 'package:jpp/ui/share/pizzeria_style.dart';
import 'package:jpp/ui/share/total_widget.dart';
import 'share/buy_button_widget.dart';

class PizzaDetails extends StatefulWidget {
  final Pizza _pizza;
  final Cart _cart;

  PizzaDetails(this._pizza, this._cart, {Key? key}) : super(key: key);

  @override
  _PizzaDetailsState createState() => _PizzaDetailsState();
}

class _PizzaDetailsState extends State<PizzaDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(widget._pizza.title, widget._cart),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          Text(
            //widget._pizza.title,
            'pizza ${widget._pizza.title}',
            style: PizzeriaStyle.pageTitleTextStyle,
          ),
          Image.asset(
            'assets/images/pizza/${widget._pizza.image}',
            height: 180,
          ),
          Text(
            'Recette',
            style: PizzeriaStyle.headerTextStyle,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 12.0),
            child: Text(
              widget._pizza.garniture,
            ),
          ),
          Text(
            'Pâte et taille sélectionnées',
            style: PizzeriaStyle.headerTextStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _buildDropDownPates()),
              Expanded(child: _buildDropDownTailles()),
            ],
          ),
          Text(
            'Sauces sélectionnées',
            style: PizzeriaStyle.headerTextStyle,
          ),
          _buildDropDownSauces(),
          TotalWidget(widget._pizza.total),
          BuyButtonWidget(widget._pizza, widget._cart),
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
        Image.asset(
          'assets/images/pizzas/${pizza.image}',
          height: 120,
          width: MediaQuery
              .of(context)
              .size
              .width,
          fit: BoxFit.fitWidth,
        ),
        Container(
          padding: const EdgeInsets.all(4.0),
          child: Text(pizza.garniture),
        ),
      ],
    );
  }

  _buildDropDownItem(List<OptionItem> list) {
    return Iterable.generate(
      list.length,
          (i) =>
          DropdownMenuItem<OptionItem>(
            value: list[i],
            child: Text(list[i].name),
          ),
    ).toList();
  }

  _buildDropDownSauces() {
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.sauces[widget._pizza.sauce],
      items: _buildDropDownItem(Pizza.sauces),
      onChanged: (item) {
        setState(() {
          widget._pizza.sauce = item!.value;
        });
      },
    );
  }

  _buildDropDownTailles() {
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.tailles[widget._pizza.taille],
      items: _buildDropDownItem(Pizza.tailles),
      onChanged: (item) {
        setState(() {
          widget._pizza.taille = item!.value;
        });
      },
    );
  }

  _buildDropDownPates() {
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.pates[widget._pizza.pate],
      items: _buildDropDownItem(Pizza.pates),
      onChanged: (item) {
        setState(() {
          widget._pizza.pate = item!.value;
        });
      },
    );
  }
}