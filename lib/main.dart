import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random(); // Add this line.
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          // Change "const" to "new".
          //child: const Text('Hello World'),   // Replace this text...
          child: new Text(wordPair.asPascalCase), // With this text.
        ),
      ),
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
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), title: Text('Merchant')),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('Profile'))
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
