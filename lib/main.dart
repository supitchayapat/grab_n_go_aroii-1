import 'package:flutter/material.dart';

class Order {
  String name;
  int price;
  int orderNumber;
  bool confirm;

  Order(this.name, this.price, this.orderNumber, this.confirm);
  
}

class OrderItemList extends StatefulWidget {
  final Order order;

  OrderItemList(Order order)
      : order = order,
        super(key: new ObjectKey(order));

  @override
  _OrderItemState createState() {
    return new _OrderItemState(order);
  }
}

class _OrderItemState extends State<OrderItemList> {
  final Order order;

  _OrderItemState(this.order);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: CircleAvatar(child: Text(order.orderNumber.toString())),
      title: new Row(
        children: <Widget>[
          new Expanded(child: new Text(order.name)),
          new Switch(
              value: order.confirm,
              onChanged: (bool value) {
                setState(() {
                  order.confirm = value;
                });
              })
        ],
      ),
      subtitle: Text('total: ' + order.price.toString() + ' baht'),
    );
  }
}

class OrderList extends StatefulWidget {
  List<Order> order;

  OrderList({Key key, this.order}) : super(key: key);

  @override
  _OrderListState createState() {
    return new _OrderListState();
  }
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Confirm Customer Orders'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(8.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Expanded(
                child: new ListView(
              padding: new EdgeInsets.symmetric(vertical: 8.0),
              children: widget.order.map((Order order) {
                return new OrderItemList(order);
              }).toList(),
            )),
            new RaisedButton(
              onPressed: () {
                for (Order o in widget.order) {
                  if (o.confirm) print('Order '+o.orderNumber.toString()+ ': '+ o.name);
                }
              },
              child: new Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(
    title: 'Demo App',
      home: new OrderList(order: [
        new Order('Isa Tusa', 150, 1, false),
        new Order('Racquel Ricciardi', 50, 2, false),
        new Order('Teresita Mccubbin', 75, 3, false),
        new Order('Rhoda Hassinger', 65, 4, false),
        new Order('Carson Cupps', 300, 5, false),
        new Order('Devora Nantz', 100, 6, false),
        new Order('Tyisha Primus', 40, 7, false),
        new Order('Muriel Lewellyn', 1000, 8, false),
        new Order('Hunter Giraud', 600, 9, false),
        new Order('Corina Whiddon', 80, 10, false),
        new Order('Meaghan Covarrubias', 90, 11, false),
        new Order('Ulysses Severson', 120, 12, false),
        new Order('Richard Baxter', 140, 13, false),
        new Order('Alessandra Kahn', 110, 14, false),
        new Order('Libby Saari', 200, 15, false),
        new Order('Valeria Salvador', 220, 16, false),
        new Order('Fredrick Folkerts', 350, 17, false),
        new Order('Delmy Izzi', 450, 18, false),
        new Order('Leann Klock', 700, 19, false),
        new Order('Rhiannon Macfarlane', 750, 20, false),
      ],),
    ));
}


