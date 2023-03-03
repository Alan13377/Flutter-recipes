import 'package:flutter/material.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';
import 'package:fooderlich/widgets/Explorer_page/friend_post_listview.dart';
import 'package:fooderlich/widgets/Explorer_page/today_recipe_list_view.dart';

//*Pagina que contiene el ListView Principal
class ExplorerPage extends StatelessWidget {
  //*Instancia de la Clase MockFooderlichService
  final mockService = MockFooderlichService();

  ExplorerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExplorerData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          //*ListView Anidado
          //*ListView de scroll vertical, el cual contiene otro ListView de scroll horizontal
          return ListView(
            scrollDirection: Axis.vertical,
            children: [
              //*ListView Recetas del dia
              TodayRecipeListView(recipes: snapshot.data!.todayRecipes),
              const SizedBox(
                height: 16,
              ),
              //*ListView Post de amigos
              FriendPostListView(friendsPost: snapshot.data!.friendsPost)
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
