import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fooderlich/models/explore_data.dart';
import 'package:fooderlich/models/explore_recipe.dart';
import 'package:fooderlich/models/post.dart';
import 'package:fooderlich/models/simple_recipe.dart';

class MockFooderlichService {
  //*Metodo que devuelve dos listas: recetas para explorar y publicaciones de amigos
  Future<ExploreData> getExplorerData() async {
    final todayRecipes = await _getTodayRecipes();
    final friendsPost = await _getFriendFeed();

    return ExploreData(todayRecipes, friendsPost);
  }

  //*Funcion que retornara las recetas mas populares del dia
  Future<List<ExploreRecipe>> _getTodayRecipes() async {
    //*Simular el tiempo de respuesta de una llamada a una api
    await Future.delayed(const Duration(milliseconds: 1000));

    //*Obtener el json del archivo
    final dataString =
        await _loadAsset("assets/sample_data/sample_explore_recipes.json");

    //*Decode Json
    final Map<String, dynamic> json = jsonDecode(dataString);

    //*Convierte la respuesta json a un objeto
    if (json["recipes"] != null) {
      final recipes = <ExploreRecipe>[];
      json["recipes"].forEach((v) {
        recipes.add(ExploreRecipe.fromJson(v));
      });
      return recipes;
    } else {
      return [];
    }
  }

  //*Funcion que retornara las recetas de tus amigos
  Future<List<Post>> _getFriendFeed() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final dataString =
        await _loadAsset('assets/sample_data/sample_friends_feed.json');

    final Map<String, dynamic> json = jsonDecode(dataString);

    if (json['feed'] != null) {
      final posts = <Post>[];
      json['feed'].forEach((v) {
        posts.add(Post.fromJson(v));
      });
      return posts;
    } else {
      return [];
    }
  }

  //* Retorna una lista de recetas
  Future<List<SimpleRecipe>> getRecipes() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final dataString =
        await _loadAsset('assets/sample_data/sample_recipes.json');

    final Map<String, dynamic> json = jsonDecode(dataString);

    if (json['recipes'] != null) {
      final recipes = <SimpleRecipe>[];
      json['recipes'].forEach((v) {
        recipes.add(SimpleRecipe.fromJson(v));
      });
      return recipes;
    } else {
      return [];
    }
  }

  //* Cargar el archivo json
  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }
}
