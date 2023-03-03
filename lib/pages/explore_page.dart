import 'package:flutter/material.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';
import 'package:fooderlich/widgets/Explorer_page/friend_post_listview.dart';
import 'package:fooderlich/widgets/Explorer_page/today_recipe_list_view.dart';

//*Pagina que contiene el ListView Principal
class ExplorerPage extends StatefulWidget {
  const ExplorerPage({super.key});

  @override
  State<ExplorerPage> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  //*Instancia de la Clase MockFooderlichService
  final mockService = MockFooderlichService();
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller.addListener(scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExplorerData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          //*ListView Anidado
          //*ListView de scroll vertical, el cual contiene otro ListView de scroll horizontal
          return ListView(
            controller: controller,
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

  void scrollListener() {
    // 1
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      print('i am at the bottom!');
    }
    // 2
    if (controller.offset <= controller.position.minScrollExtent &&
        !controller.position.outOfRange) {
      print('i am at the top!');
    }
  }
}
