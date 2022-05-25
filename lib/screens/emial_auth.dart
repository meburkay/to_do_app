import 'package:flutter/material.dart';

class EmailAuth extends StatefulWidget {
  EmailAuth({Key? key}) : super(key: key);

  @override
  State<EmailAuth> createState() => _EmailAuthState();
}

class _EmailAuthState extends State<EmailAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(),
            TextField(),
            ElevatedButton(
              onPressed: () {},
              child: Text("Giriş Yapın"),
            )
          ],
        ),
      ),
    );
  }
}
