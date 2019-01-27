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
      home: HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have Clicked the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class Showmap{
  Widget build(BuildContext context){
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bts_map.jpg'),
        )
      )
    );
  }
}

class SearchMerchant extends StatefulWidget {
  @override
  SearchMerchantState createState() => new SearchMerchantState();
}

class SearchMerchantState extends State<SearchMerchant> {
  int _selectedIndex = 0;
  // final List<String> _MerchantList = ['A', 'B', 'C'];
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Grab & Go"),
      ),
      body: RandomWords(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home' , style: TextStyle(fontSize: 17.5),)),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), title: Text('Merchant', style: TextStyle(fontSize: 17.5),)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('Profile' , style: TextStyle(fontSize: 17.5),))
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepOrange,
        onTap: _onItemTapped,
      ),
    );
  }
  void _onItemTapped(int index){
    setState(() {
          return 1;
        });
  }
}
class Store {
  //--- Name Of Store
  final String name;
  //-- image
  final String image;
  //--- population
  final String rate;

  Store({this.name,this.rate,this.image}); 
  static List<Store> allStore()
{
  var lstOfStore = new List<Store>();

  lstOfStore.add(new Store(name:"ยูทาโกะ",rate: "5 star",image: "tako.jpg"));
  lstOfStore.add(new Store(name:"ไข่เจียว",
                 rate: "4 star",image: "ไข่เจียว.jpg"));
  lstOfStore.add(new Store(name:"coffee prince",
                  rate: "3.5 star",image: "coffee.jpg"));
  lstOfStore.add(new Store(name:"twits potato",
                 rate: "3.5 star",image: "potato.jpg"));
  return lstOfStore;
  
}

}

class HomePage extends StatelessWidget {
 
List<Store> _allStore = Store.allStore();

HomePage();

@override
Widget build(BuildContext context) {
  return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Store around หมอชิต",
          style: new TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
      ),
      body: new Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          child: getHomePageBody(context)));
}

getHomePageBody(BuildContext context) {
  return ListView.builder(
    itemCount: _allStore.length,
    itemBuilder: _getItemUI,
    padding: EdgeInsets.all(0.0),
  );
}
  // First Attempt

  Widget _getItemUI(BuildContext context, int index) {
    return new Card(
      child: new Column(
    
    children: <Widget>[
      new ListTile(
        leading: new Image.asset(
          "assets/" + _allStore[index].image,
          fit: BoxFit.cover,
          width: 70.0,
        ),

        title: new Text(
          _allStore[index].name,
          style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        subtitle: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text('Population: ${_allStore[index].rate}',
                  style: new TextStyle(
                      fontSize: 11.0, fontWeight: FontWeight.normal)),
            ]),
        //trailing: ,
        onTap: () {
          //change page
        },
      )
    ],
  ));
}
}