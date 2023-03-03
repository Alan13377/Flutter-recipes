import 'package:flutter/material.dart';
import 'package:fooderlich/utils/theme.dart';
import 'package:fooderlich/widgets/Explorer_page/circle_image.dart';

class AuthorCard extends StatefulWidget {
  final String authorName;
  final String title;
  final ImageProvider? imageProvider;
  const AuthorCard(
      {super.key,
      required this.authorName,
      required this.title,
      this.imageProvider});

  @override
  State<AuthorCard> createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      //*Row que mostrara - image-texto,icono
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleImage(
            imageProvider: widget.imageProvider,
            imageRadius: 28,
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.authorName,
                style: FooderlichTheme.lightTextTheme.displayMedium,
              ),
              Text(
                widget.title,
                style: FooderlichTheme.lightTextTheme.displaySmall,
              )
            ],
          ),
          IconButton(
            icon: isFavorite
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
            iconSize: 30,
            color: Colors.red[400],
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
    );
  }
}
