import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokeapp/pokemon.dart';
import 'package:pokeapp/pokemondetail.dart';

void main()=> runApp(MaterialApp(
  title: 'Pokédesk',
  home: HomePage(),
  debugShowCheckedModeBanner: false,
  
));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  RefreshIndicatorState refreshIndicatorState = RefreshIndicatorState();


  var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  
  PokeHub pokeHub = PokeHub();

  @override
  void initState() {
    fetchData();
    super.initState();


  }

  fetchData() async {

    pokeHub = PokeHub();

    setState(() {

    });

    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    
    pokeHub = PokeHub.fromJson(decodedJson);

    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: Text('Pokédesk'),
        backgroundColor: Colors.cyan,
      ),
      body: pokeHub.pokemon == null
          ? Center(child: CircularProgressIndicator(strokeWidth: 2.0,))
          : GridView.count(
          crossAxisCount: 2,
          children: pokeHub.pokemon?.map((poke)=> Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
              PokeDetail(poke)));
            },
            child: Hero(
              tag: poke.img,
              child: Card(
                elevation: 3.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(poke.img)),
                      ),
                    ),
                    Text(poke.name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          ),
        ))?.toList() ?? [],
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          fetchData();
        },
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
