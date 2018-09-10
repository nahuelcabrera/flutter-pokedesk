

import 'package:flutter/material.dart';
import 'package:pokeapp/pokemon.dart';

class PokeDetail extends StatelessWidget {

  final Pokemon pokemon;


  PokeDetail(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(pokemon.name),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: bodyWidget(context),
    );
  }

  bodyWidget(BuildContext context) => Stack(
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width - 20,
        left: 10.0,
        top: MediaQuery.of(context).size.height * 0.1,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 100.0,
              ),
              Text(pokemon.name, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),),
              Text("Height: ${pokemon.height}"),
              Text("Weight: ${pokemon.weight}"),
              Text("Types", style: TextStyle(fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.type?.map((t) => FilterChip(
                    backgroundColor: Colors.yellow,
                    label: Text(t),
                    onSelected: (b){}
                    ))?.toList() ?? []
              ),
              Text("Weakness", style: TextStyle(fontWeight: FontWeight.bold),),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.weaknesses?.map((t) => FilterChip(
                      backgroundColor: Colors.red,
                      label: Text(t, style: TextStyle(color: Colors.white),),
                      onSelected: (b){}
                      ))?.toList() ?? []
              ),
              Text("Next Evolution", style: TextStyle(fontWeight: FontWeight.bold),),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.nextEvolution?.map((n) => FilterChip(
                      backgroundColor: Colors.green,
                      label: Text(n.name, style: TextStyle(color: Colors.white),),
                      onSelected: (b){}
                      ))?.toList() ?? [Text('No more evolutions')]
              )
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Hero(tag: pokemon.img, child: Container(
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(pokemon.img))
          ),
        )),
      )
    ],
  );
}
