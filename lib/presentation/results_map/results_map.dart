import 'package:flutter/material.dart';

class ResultsMapScreen extends StatelessWidget {
  const ResultsMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic data = ModalRoute.of(context)!.settings.arguments;
    final List cells = data[0];
    final List resultCells = cells.sublist(1, cells.length - 1);
    print(resultCells);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Result list screen"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: data[1].field!.length,
        ),
        itemCount: data[1].field!.length * data[1].field!.length,
        itemBuilder: (BuildContext context, int index) {
          final num x = index % data[1].field!.length;
          final int y = index ~/ data[1].field!.length;

          Color cellColor = Colors.white;

          final int startX = data[1].start!.x!;
          final int startY = data[1].start!.y!;
          final int endX = data[1].end!.x!;
          final int endY = data[1].end!.y!;

          if (x == startX && y == startY) {
            cellColor = const Color.fromRGBO(100, 255, 218, 1);
          } else if (x == endX && y == endY) {
            cellColor = const Color.fromRGBO(0, 150, 136, 1);
          } else if (resultCells.any((step) => step.x == '$x' && step.y == '$y')) {
            cellColor = const Color.fromRGBO(76, 175, 80, 1);
          }

          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: cellColor,
            ),
            child: Center(
              child: Text(
                "($x, $y)",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
