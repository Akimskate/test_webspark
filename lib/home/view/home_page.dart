import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home Page'),
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              'Set valid API base URL in order to continue',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.sync_alt),
              SizedBox(width: 300, child: TextField()),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {},
          child: const Center(
            child: Text('Start counting process'),
          ),
        ),
      ),
    );
  }
}
