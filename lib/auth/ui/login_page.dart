import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whiteboard_flutter/auth/model/user.dart';
import 'package:whiteboard_flutter/auth/components/email_login_form_dialog.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pageController = PageController(
      initialPage: 0,
    );

    final tutorial = const [
      Text(
        'Wellcome\nto\nWhiteBoard!!',
        style: TextStyle(fontSize: 55),
        textAlign: TextAlign.center,
      ),
      Text(
        'ホワイトボードは、グループ内での情報の共有に特化したアプリです。',
        style: TextStyle(fontSize: 40),
        textAlign: TextAlign.center,
      ),
    ].map(
      (e) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: e,
          ),
        );
      },
    ).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(children: [
                PageView(
                  controller: _pageController,
                  children: tutorial,
                ),
              ]),
            ),
            Divider(
              height: 0.1,
              color: Colors.grey.shade900,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40, top: 10),
              child: SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      context.read(userStateProvider.notifier).signInAtGoogle,
                  child: const Text(
                    'Googleで続行',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40, top: 10),
              child: SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await showDialog<EmailLoginFormDialog>(
                      context: context,
                      builder: (context) => EmailLoginFormDialog(
                        onSubmit: context
                            .read(userStateProvider.notifier)
                            .signInAtEmail,
                      ),
                    );
                  },
                  child: const Text(
                    'メールアドレスで続行',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
