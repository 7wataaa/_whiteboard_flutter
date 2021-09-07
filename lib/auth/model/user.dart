import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'user.freezed.dart';

final userStateProvider = StateNotifierProvider<UserStateNotifier, User>((ref) {
  return UserStateNotifier();
});

@freezed
class User with _$User {
  factory User({
    required String name,
    required String email,
    required String photoUrl,
    required String id,
  }) = _User;
}

final googleSignIn = GoogleSignIn(clientId: dotenv.env['CLIENT_ID']);

class UserStateNotifier extends StateNotifier<User> {
  UserStateNotifier() : super(User(name: '', email: '', photoUrl: '', id: ''));

  Future<void> signInAtGoogle() async {
    await googleSignIn.signIn();

    final currentUser = googleSignIn.currentUser;

    if (currentUser != null) {
      debugPrint((await currentUser.authentication).idToken);
    } else {
      debugPrint('ログイン失敗');
    }

    state = state.copyWith(
      name: currentUser?.displayName ?? '',
      email: currentUser?.email ?? '',
      photoUrl: currentUser?.photoUrl ?? '',
      id: (await currentUser?.authentication)?.idToken ?? '',
    );
  }

  Future<void> signInAtEmail(String emailAddress, String password) async {
    debugPrint('emailAddress: $emailAddress, password: $password');
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();

    final currentUser = googleSignIn.currentUser;

    state = state.copyWith(
      name: currentUser?.displayName ?? '',
      email: currentUser?.email ?? '',
      photoUrl: currentUser?.photoUrl ?? '',
      id: (await currentUser?.authentication)?.idToken ?? '',
    );

    debugPrint('サインアウトしました');
  }
}
