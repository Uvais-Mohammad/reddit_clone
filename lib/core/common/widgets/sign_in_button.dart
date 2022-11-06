import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/constants/asset_manager.dart';
import 'package:reddit_clone/core/locale/localization.dart';
import 'package:reddit_clone/features/auth/controllers/auth_controller.dart';
import 'package:reddit_clone/theme/pallette.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({
    Key? key,
  }) : super(key: key);

  void signIn(WidgetRef ref,BuildContext context) {
    ref.read(authControllerProvider).googleSignIn(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: () => signIn(ref,context),
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
