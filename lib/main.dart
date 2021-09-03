import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whiteboard_flutter/auth/model/user.dart';
import 'package:whiteboard_flutter/auth/ui/login_page.dart';
import 'package:whiteboard_flutter/home/ui/home_page.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  late final SharedPreferences sharedPreferences;

  await Future.wait([
    Future(() async {
      sharedPreferences = await SharedPreferences.getInstance();
    }),
    dotenv.load(fileName: '.env'),
  ]);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final user = watch(userStateProvider);

      debugPrint(user.email);

      debugPrint(googleSignIn.currentUser.toString());

      if (user.email.isNotEmpty) {
        return const HomePage();
      } else {
        return const LoginPage();
      }
    });
  }
}
