import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se380_project/main.dart';
import 'package:se380_project/models/recipe_model.dart';
import 'package:provider/provider.dart';
class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<DocumentSnapshot> _favoriteRecipes = [];
  @override
  void initState() {
    super.initState();
    _getFavorites();
  }

  _getFavorites() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection("favorites").get();
    setState(() {
      _favoriteRecipes = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: ListView.builder(
          itemCount: _favoriteRecipes.length,
          itemBuilder: (context, index) {
            DocumentSnapshot favorite = _favoriteRecipes[index];
            return Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 20),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    border: Border.all(
                      color: Colors.indigo,
                      width: 1,
                    ),
                  ),
                    child: ListTile(
                      title: (favorite.data() as Map<String, dynamic>)?["title"] != null
                          ? Text((favorite.data() as Map<String, dynamic>)["title"])
                          : Text(""),

                    )
                ),
              ),
            );
          }),
    );
  }
}