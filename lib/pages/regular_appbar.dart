import 'package:flutter/material.dart';

class RegularAppbarScreen extends StatefulWidget {
  const RegularAppbarScreen({Key? key}) : super(key: key);

  @override
  State<RegularAppbarScreen> createState() => _RegularAppbarScreenState();
}

class _RegularAppbarScreenState extends State<RegularAppbarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gradient Appbar'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffB983FF),
                Color(0xff94B3FD),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: ((context, index) {
          return Card(
            child: ListTile(
              title: Text('Item number $index'),
              subtitle: const Text('This is a subtitle'),
              trailing: const Icon(Icons.delete),
            ),
          );
        }),
      ),
    );
  }
}
