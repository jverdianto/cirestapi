import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:week_6/services/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final _loginKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();

  void dispose() {
    ctrlEmail.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _loginKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      prefixIcon: Icon(Icons.email),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    controller: ctrlEmail,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return !EmailValidator.validate(value.toString())
                          ? 'Email tidak valid!'
                          : null;
                    }),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_loginKey.currentState!.validate()) {
            await EmailService.sendEmail(ctrlEmail.text.toString()).then((value) {
              // var result = json.decode(value.body);
              // Fluttertoast.showToast(msg: result['message'].toString());
              Fluttertoast.showToast(msg: "Email sent! Please check your email");
            });
          } else {
            Fluttertoast.showToast(msg: "Please fill all field!");
          }
        },
        tooltip: 'Send Email',
        child: const Icon(Icons.send),
      ),
    );
  }
}
