import 'package:fooderlich/models/explore_recipe.dart';
import 'package:fooderlich/models/post.dart';

//*Modelo para agrupar dos conjuntos de datos
//*Contiene la lista de ExploreRecipes y la lista de Post
class ExploreData {
  final List<ExploreRecipe> todayRecipes;
  final List<Post> friendsPost;

  ExploreData(this.todayRecipes, this.friendsPost);
}
