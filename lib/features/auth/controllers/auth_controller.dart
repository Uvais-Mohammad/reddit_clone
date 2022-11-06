import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/utils/utils.dart';
import 'package:reddit_clone/features/auth/repository/auth_repository.dart';
import 'package:reddit_clone/models/user_model.dart';

final userProvider = StateProvider<UserModel?>(((ref) => null));

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.read(authRepositoryProvider),
    ref: ref,
  ),
);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false);

  void googleSignIn(BuildContext context) async {
    state = true;
    var result = await _authRepository.googleSignIn();
    state = false;
    result.fold((l) => showSnackBar(context, l.message),
        (r) => _ref.read(userProvider.notifier).update((state) => null));
  }
}
