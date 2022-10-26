import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit_clone/core/constants/asset_manager.dart';
import 'package:reddit_clone/core/constants/firebase_constants.dart';
import 'package:reddit_clone/core/providers/failure.dart';
import 'package:reddit_clone/core/providers/firebase_providers.dart';
import 'package:reddit_clone/core/type_defs.dart';
import 'package:reddit_clone/models/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    firebaseAuth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
    fireStore: ref.read(firestoreProvider),
    firebaseStorage: ref.read(storageProvider),
  ),
);

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _fireStore;
  final FirebaseStorage _firebaseStorage;

  AuthRepository({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required FirebaseFirestore fireStore,
    required FirebaseStorage firebaseStorage,
  })  : _firebaseAuth = firebaseAuth,
        _fireStore = fireStore,
        _firebaseStorage = firebaseStorage,
        _googleSignIn = googleSignIn;

  FutureEither<UserModel> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleSignInAccount?.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      UserModel userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        User user = userCredential.user!;
        userModel = UserModel(
          name: user.displayName ?? '',
          profilePic: AssetManager.avatarDefault,
          banner: AssetManager.bannerDefault,
          uid: userCredential.user!.uid,
          isAuthenticated: false,
          karma: 0,
          awards: [],
        );

        _users.doc(user.uid).set(userModel.toMap());
      } else {
        userModel = await _getUserData(userCredential.user!.uid).first;
      }

      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  CollectionReference get _users =>
      _fireStore.collection(FirebaseConstants.usersCollection);

  Stream<UserModel> _getUserData(String uid) => _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(
          event.data() as Map<String, dynamic>,
        ),
      );
}
