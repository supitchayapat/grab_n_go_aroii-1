import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Aroii',
      theme: new ThemeData(
        primaryColor: Colors.yellow,
      ),
      home: SearchMerchant(),
      routes: <String, WidgetBuilder> {
        "/YutakoPage": (BuildContext context) => new YutakoPage() 
      },
    );
  }
}

class SearchMerchant extends StatefulWidget {
  @override
  GrabNGoPage createState() => new GrabNGoPage();
}

class GrabNGoPage extends State<SearchMerchant> {
  int _selectedIndex = 0;
  List<String> _merchantLists = <String>[];
  List<String> _merchantBts = <String>['ยูทาโกะ', 'ไข่เจียวคุณหญิง', 'Coffee Prince', 'Twist Potato'];
  List<String> _merchantMrt = <String>['D', 'E', 'F'];
  List<String> _merchantArl = <String>['G', 'H', 'I']; 
  final List<String> _shoppingCart = <String>[];
  // final List<String> _MerchantList = ['A', 'B', 'C'];
  Widget build(BuildContext context){
    return 
    Scaffold(
      appBar: AppBar(
        title: Text("Grab & Go"),
        actions: <Widget>[
          new IconButton(icon:  const Icon(Icons.shopping_cart), onPressed: _showCart,),
        ],
      ),
      body: _buildHomePageDetail(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), title: Text('Merchant')),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('Profile'))
        ],
        currentIndex: 1,
        fixedColor: Colors.deepOrange,
        onTap: _onItemTapped,
      ),
    );
  }
  Widget _buildHomePageDetail(){
    return new MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            // titleSpacing: 50,
            // backgroundColor: Colors.red,
            title: TabBar(
              // isScrollable: true,
              tabs: tabList.map((Tabs tabs) {
                return Tab(
                  text: tabs.title,
                  icon: Icon(tabs.icon),
                );
              }).toList(),
            ),
          ),
        body: _buildMerchantList('BTS'),
        // body: _buildMerchantList(),  
        ),
      ),
    );
  }
  Widget _buildMerchantList(String title){
    title == 'BTS' ? _merchantLists = _merchantBts : 
    title == 'MRT' ? _merchantLists = _merchantMrt :
    _merchantLists = _merchantArl;

    return ListView.builder(
      padding: EdgeInsets.all(30.0),
      itemCount: _merchantLists.length,
      itemBuilder: (context, i){
        return _buildRow(_merchantLists[i], i);
      },
    );    
  }
  Widget _buildRow(String merchant, int i){
    return ListTile(
      contentPadding: EdgeInsets.all(30.0),
      leading: new Image.asset('assets/'+ _merchantLists[i] +'.jpg', fit: BoxFit.cover, width: 70.0,),
      title: Text(merchant, style: const TextStyle(fontSize: 22.0),),
      trailing: new Icon(Icons.chevron_right),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => YutakoPage()),
        );
      },
    );
  }
  void _onItemTapped(int index){
    setState(() {
          _selectedIndex = index;
        });
  }
  void _showCart(){

  }
}

class YutakoPage extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('ยูทาโกะ'),
        actions: <Widget>[
          // new IconButton(icon: Icon(Icons.backspace), onPressed: (){},)
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(30.0),
        itemCount: 10,
        itemBuilder: (context, i){
          return ListTile(
            contentPadding: EdgeInsets.all(30.0),
            leading: Text('Menu '+ i.toString(), style: TextStyle(fontSize: 18.0),),
            subtitle: Text('Price: ' + (i+10).toString()),
          );
        },
      )
    );
  }
}

class OrderHistory extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
    );
  }
}

class ShoppingCart extends StatelessWidget {
   @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
    );
  }  
}

class Tabs {
  const Tabs({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Tabs> tabList = const <Tabs>[
  const Tabs(title: 'BTS', icon: Icons.directions_railway),
  const Tabs(title: 'MRT', icon: Icons.directions_subway),
  const Tabs(title: 'ARL', icon: Icons.train),
  const Tabs(title: 'BUS', icon: Icons.directions_bus),
];

class MerchantView extends StatelessWidget {
  const MerchantView({Key key, this.tab}) : super(key: key);
  final Tabs tab;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GrabNGoPage()._buildMerchantList(tab.title),
    );
  }
}

class Store {
  final String name;
  final String image;
  final String rate;

  Store({this.name, this.image, this.rate});
  static List<Store> allStore(){
    var lstOfStore = new List<Store>();
    lstOfStore.add(new Store(name:"ยูทาโกะ",rate: "5 star",image: "tako.jpg"));
    lstOfStore.add(new Store(name:"ไข่เจียว", rate: "4 star",image: "ไข่เจียว.jpg"));
    lstOfStore.add(new Store(name:"coffee prince", rate: "3.5 star",image: "coffee.jpg"));
    lstOfStore.add(new Store(name:"twits potato", rate: "3.5 star",image: "potato.jpg"));
  
  return lstOfStore;
  }
}