import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final double imageRadius;
  final ImageProvider? imageProvider;
  const CircleImage({
    super.key,
    required this.imageRadius,
    this.imageProvider,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: imageRadius,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: imageRadius - 5,
        backgroundImage: imageProvider,
      ),
    );
  }
}
