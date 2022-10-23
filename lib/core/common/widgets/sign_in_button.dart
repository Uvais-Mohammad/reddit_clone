import 'package:flutter/material.dart';
import 'package:reddit_clone/core/constants/asset_manager.dart';
import 'package:reddit_clone/core/locale/localization.dart';
import 'package:reddit_clone/theme/pallette.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallette.greyColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetManager.google, height: 30),
            const SizedBox(width: 10),
            const Text(
              LocalizationStrings.continueWithGoogle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
