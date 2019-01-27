import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

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
    );
  }
}

class RandomWordsState extends State<RandomWords> {
    final List<WordPair> _suggestions = <WordPair>[];
    final Set<WordPair> _saved = new Set<WordPair>();
    final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

    Widget _buildSuggestion(){
      return ListView.builder(
        padding: const EdgeInsets.all(30.0),
        itemBuilder: (context, i){
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length){
            _suggestions.addAll(generateWordPairs().take(1));
          }
          return _buildRow(_suggestions[index]);
        });
    }
    Widget _buildRow(WordPair pair){
      final bool alreadySaved = _saved.contains(pair);
      return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: new Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: (){
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        },
      );
    }
    Widget build(BuildContext context) {
      return Scaffold(
        appBar:  AppBar(
          title: Text('Grab & Go'),
          actions: <Widget>[
            new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
          ],
        ),
        body: _buildSuggestion(),
      );
    }
    void _pushSaved() {
      Navigator.of(context).push(
        new MaterialPageRoute<void>(
          builder: (BuildContext context){
            final Iterable<ListTile> tiles = _saved.map(
              (WordPair pair) {
                return new ListTile(
                  title: new Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              },
            );
            final List<Widget> divided = ListTile.divideTiles(
              context: context,
              tiles: tiles,
            ).toList();
            return new Scaffold(
              appBar: new AppBar(
                title: const Text('Saved Suggestion'),
              ),
              body: new ListView(children: divided),
            );
          },
        ),
      );
    }
}

class SearchMerchant extends StatefulWidget {
  @override
  GrabNGoPage createState() => new GrabNGoPage();
}

class GrabNGoPage extends State<SearchMerchant> {
  int _selectedIndex = 0;
  List<String> _merchantLists = <String>['GG'];
  List<String> _merchantBts = <String>['A', 'B', 'C'];
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
            titleSpacing: 50,
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
        body: TabBarView(
          children: tabList.map((Tabs tabs) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: MerchantView(tab: tabs,),
            );
          }).toList(),
        ),
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
      return _buildRow(_merchantLists[i]);
      },
    );    
  }
  Widget _buildRow(String merchant){
    return ListTile(
        title: Text(merchant, style: const TextStyle(fontSize: 30.0),),
        trailing: new Icon(Icons.chevron_right),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MerchantPage()),
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

class MerchantPage extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Merchant Page'),
        actions: <Widget>[
          // new IconButton(icon: Icon(Icons.backspace), onPressed: (){},)
        ],
      ),
      body: Center(
        child: RaisedButton(
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ShoppingCart()),
            );
          },
        ),
      ),
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
    // return Card(
    //   child: Center(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: <Widget>[
    //         Icon(tab.icon, size: 128.0,)
    //       ],
    //     ),
    //   ),
    // );
  }
}
