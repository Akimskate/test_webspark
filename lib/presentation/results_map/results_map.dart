import 'package:flutter/material.dart';

class ResultsMapScreen extends StatelessWidget {
  const ResultsMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic fieldData = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Result list screen"),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: fieldData?.field?.length,
          ),
          itemCount: fieldData!.field!.length * fieldData.field!.length,
          itemBuilder: (BuildContext context, int index) {
            final num x = index % fieldData!.field!.length;
            final int y = index ~/ fieldData.field!.length;
            final String cellValue = fieldData.field![y][x];

            Color cellColor = cellValue == 'X' ? Colors.black : Colors.white;

            final int startX = fieldData.start!.x!;
            final int startY = fieldData.start!.y!;
            final int endX = fieldData.end!.x!;
            final int endY = fieldData.end!.y!;

            if (x == startX && y == startY) {
              cellColor = const Color.fromRGBO(100, 255, 218, 1);
            } else if (x == endX && y == endY) {
              cellColor = const Color.fromRGBO(0, 150, 136, 1);
            }

            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: cellColor, // Установить цвет ячейки
              ),
              child: Center(
                child: Text("($x, $y)"),
              ),
            );
          }),
    );
  }
}
