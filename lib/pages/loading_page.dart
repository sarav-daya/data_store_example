import 'package:flutter/material.dart';

import '../loading/loading_screen.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  int _counter = 0;

  void _incrementCounter() async {
    // Call LoadingScreen().show() to SHOW  Loading Dialog
    LoadingScreen().show(
      context: context,
      text: 'Please wait a moment',
    );

    // await for 2 seconds to Mock Loading Data
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _counter++;
    });
    LoadingScreen().show(
      context: context,
      text: 'Almost there',
    );
    await Future.delayed(const Duration(seconds: 2));

    // Call LoadingScreen().hide() to HIDE  Loading Dialog
    LoadingScreen().hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
              textAlign: TextAlign.center,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
