import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/utils/utils.dart';
import 'package:reddit_clone/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider<AuthController>(
  (ref) => AuthController(
    authRepository: ref.read(authRepositoryProvider),
  ),
);

class AuthController {
  final AuthRepository _authRepository;
  AuthController({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  void googleSignIn(BuildContext context) async {
    var result = await _authRepository.googleSignIn();
    result.fold((l) => showSnackBar(context, l.message), (r) => print(r.toJson()));
  }
}
