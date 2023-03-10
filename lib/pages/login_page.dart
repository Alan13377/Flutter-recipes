import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooderlich/models/app_state_manager.dart';

class LoginPage extends ConsumerWidget {
  final String? username;
  final Color rwColor = const Color.fromRGBO(64, 143, 77, 1);
  final TextStyle focusedStyle = const TextStyle(color: Colors.green);
  final TextStyle unFocusedStyle = const TextStyle(color: Colors.grey);
  const LoginPage({super.key, this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(appStateManagerProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.only(top: 44),
            children: [
              const SizedBox(
                height: 200,
                child: Image(
                  image: AssetImage(
                    "assets/magazine_pics/card_bread.jpg",
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              buildTextField(username ?? "🍔 password"),
              const SizedBox(
                height: 16,
              ),
              buildTextField("🍔 password"),
              const SizedBox(
                height: 16,
              ),
              buildButton(context, manager)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hintText) {
    return TextField(
      cursorColor: rwColor,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(height: 0.5),
      ),
    );
  }

  Widget buildButton(context, manager) {
    return SizedBox(
      height: 55,
      child: MaterialButton(
        color: rwColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          manager.login("alan", "123456");
        },
      ),
    );
  }
}
