import 'package:flutter/material.dart';
import 'package:reddit_clone/core/common/widgets/sign_in_button.dart';
import 'package:reddit_clone/core/constants/asset_manager.dart';
import 'package:reddit_clone/core/locale/localization.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AssetManager.logo, height: 40),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              LocalizationStrings.skip,
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            LocalizationStrings.diveIntoAnything,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          Image.asset(AssetManager.loginEmote),
          const SizedBox(height: 25),
          const SignInButton(),
        ],
      ),
    );
  }
}
