import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooderlich/models/app_state_manager.dart';
import 'package:fooderlich/models/profile_manager.dart';
import 'package:fooderlich/models/user.dart';
import 'package:fooderlich/widgets/Explorer_page/circle_image.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

//*Administra el estado del perfil del usuario, por ejemplo,
//*obteniendo la información del usuario,
//*verificando si el usuario está viendo su perfil y configurando el modo oscuro
class ProfilePage extends StatefulWidget {
  final User user;
  final int currentTab;

  const ProfilePage({
    super.key,
    required this.user,
    required this.currentTab,
  });

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            buildProfile(),
            Expanded(
              child: buildMenu(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenu() {
    return Consumer(builder: (context, ref, child) {
      return ListView(
        children: [
          buildDarkModeRow(),
          ListTile(
            title: const Text('View raywenderlich.com'),
            onTap: () async {
              if (kIsWeb || Platform.isMacOS) {
                await launchUrl(Uri.parse('https://www.raywenderlich.com/'));
              } else {
                context.goNamed(
                  'rw',
                  params: {'tab': '${widget.currentTab}'},
                );
              }
            },
          ),
          ListTile(
            title: const Text('Log out'),
            onTap: () {
              ref.watch(appStateManagerProvider).logout();
            },
          )
        ],
      );
    });
  }

  Widget buildDarkModeRow() {
    return Consumer(builder: (context, ref, child) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Dark Mode'),
            Switch(
              value: widget.user.darkMode,
              onChanged: (value) {
                ref.watch(profileManagerProvider).darkMode = value;
              },
            )
          ],
        ),
      );
    });
  }

  Widget buildProfile() {
    return Column(
      children: [
        CircleImage(
          imageProvider: AssetImage(widget.user.profileImageUrl),
          imageRadius: 60.0,
        ),
        const SizedBox(height: 16.0),
        Text(
          widget.user.firstName,
          style: const TextStyle(
            fontSize: 21,
          ),
        ),
        Text(widget.user.role),
        Text(
          '${widget.user.points} points',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
