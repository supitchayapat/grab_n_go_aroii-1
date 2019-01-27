import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class Order {
  Order({this.name, this.orderNumber, this.price});
  final String name;
  final int orderNumber;
  final int price;
}

class _State extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
        title: new Text('Confirm customer orders'),
      ),
      body: Container(
        child: _buildContent(),
      ),
    ));
  }

  Widget _buildContent() {
    return ListView.builder(
        itemCount: allOrders.length,
        itemBuilder: (BuildContext content, int index) {
          Order order = allOrders[index];
          return OrderListTitle(order);
        });
  }
}

class OrderListTitle extends ListTile {
  OrderListTitle(Order order)
      : super(
          title: Text('Order: ' + order.name),
          subtitle: Text('total: ' + order.price.toString()),
          leading: CircleAvatar(child: Text(order.orderNumber.toString())),
        );
}

  List<Order> allOrders = [
  Order(name: 'Isa Tusa', price: 150, orderNumber: 1),
  Order(name: 'Racquel Ricciardi', price: 50, orderNumber: 2),
  Order(name: 'Teresita Mccubbin', price: 75, orderNumber: 3),
  Order(name: 'Rhoda Hassinger', price: 65, orderNumber: 4),
  Order(name: 'Carson Cupps', price: 300, orderNumber: 5),
  Order(name: 'Devora Nantz', price: 100, orderNumber: 6),
  Order(name: 'Tyisha Primus', price: 40, orderNumber: 7),
  Order(name: 'Muriel Lewellyn', price: 1000, orderNumber: 8),
  Order(name: 'Hunter Giraud', price: 600, orderNumber: 9),
  Order(name: 'Corina Whiddon', price: 80, orderNumber: 10),
  Order(name: 'Meaghan Covarrubias', price: 90, orderNumber: 11),
  Order(name: 'Ulysses Severson', price: 120, orderNumber: 12),
  Order(name: 'Richard Baxter', price: 140, orderNumber: 13),
  Order(name: 'Alessandra Kahn', price: 110, orderNumber: 14),
  Order(name: 'Libby Saari', price: 200, orderNumber: 15),
  Order(name: 'Valeria Salvador', price: 220, orderNumber: 16),
  Order(name: 'Fredrick Folkerts', price: 350, orderNumber: 17),
  Order(name: 'Delmy Izzi', price: 450, orderNumber: 18),
  Order(name: 'Leann Klock', price: 700, orderNumber: 19),
  Order(name: 'Rhiannon Macfarlane', price: 750, orderNumber: 20),
];





