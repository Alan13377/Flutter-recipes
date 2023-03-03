import 'package:flutter/material.dart';
import 'package:fooderlich/models/post.dart';
import 'package:fooderlich/widgets/Explorer_page/friend_post_tile.dart';

class FriendPostListView extends StatelessWidget {
  final List<Post> friendsPost;
  const FriendPostListView({super.key, required this.friendsPost});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Social Chefs",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(
            height: 16,
          ),
          ListView.separated(
              //*Permite saber que esta no es la vista de desplazamiento principal
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final post = friendsPost[index];

                return FriendPostTile(post: post);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              },
              itemCount: friendsPost.length),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
