import 'package:flutter/material.dart';

typedef EmailAddressAndPasswodFunc = void Function(
  String emailAddress,
  String password,
);

class EmailLoginFormDialog extends StatefulWidget {
  const EmailLoginFormDialog({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _EmailLoginFormDialogState createState() => _EmailLoginFormDialogState();

  final EmailAddressAndPasswodFunc onSubmit;
}

class _EmailLoginFormDialogState extends State<EmailLoginFormDialog> {
  final _emailAddressEditingController = TextEditingController();

  final _passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _emailAddressEditingController.text = '';
    _passwordEditingController.text = '';

    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'メールアドレス *',
            ),
            autofocus: true,
            controller: _emailAddressEditingController,
            validator: (str) {
              debugPrint((str != null &&
                      RegExp(r'[\w\-._]+@[\w\-._]+\.[A-Za-z]+').hasMatch(str))
                  .toString());
              return (str != null &&
                      RegExp(r'[\w\-._]+@[\w\-._]+\.[A-Za-z]+').hasMatch(str))
                  ? null
                  : '正しいメールアドレスを入力してください';
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.password),
              labelText: 'パスワード *',
            ),
            controller: _passwordEditingController,
            validator: (String? value) {
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onSubmit(
              _emailAddressEditingController.text,
              _passwordEditingController.text,
            );

            Navigator.pop(context);
          },
          child: const Text('続行'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('キャンセル'),
        ),
      ],
    );
  }
}
