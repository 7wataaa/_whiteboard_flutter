import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whiteboard_flutter/auth/model/user.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhiteBoard'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: ElevatedButton(
            onPressed: context.read(userStateProvider.notifier).signOut,
            child: const Text('ログアウト'),
          ),
        ),
      ),
    );
  }
}
