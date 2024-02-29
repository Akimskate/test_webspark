import 'dart:collection';

import 'package:test_webspark/domain/model/result_model.dart';
import 'package:test_webspark/domain/model/task_model.dart';

ResultModel dijkstra(List<String> field, Start start) {
  final int rows = field.length;
  final int cols = field[0].length;

  List<List<int>> distance = List.generate(rows, (i) => List.filled(cols, 9999));
  List<List<Steps>> steps = List.generate(rows, (i) => List.filled(cols, Steps(x: '-1', y: '-1')));

  Queue<Start> queue = Queue();

  distance[start.y!][start.x!] = 0;
  queue.add(start);

  while (queue.isNotEmpty) {
    Start current = queue.removeFirst();
    int x = current.x!;
    int y = current.y!;

    List<Start> neighbors = [
      Start(x: x - 1, y: y), // Левая
      Start(x: x + 1, y: y), // Правая
      Start(x: x, y: y - 1), // Верхняя
      Start(x: x, y: y + 1), // Нижняя
    ];

    for (var neighbor in neighbors) {
      int nx = neighbor.x!;
      int ny = neighbor.y!;

      if (nx >= 0 && nx < cols && ny >= 0 && ny < rows) {
        int newDistance = distance[y][x] + (field[ny][nx] == 'X' ? 1 : 0);

        if (newDistance < distance[ny][nx]) {
          distance[ny][nx] = newDistance;
          steps[ny][nx] = Steps(x: '$x', y: '$y');
          queue.add(Start(x: nx, y: ny));
        }
      }
    }
  }

  // Формирование списка шагов и пути
  List<Steps> pathSteps = [];
  Start current = start;
  while (current.x != '-1' && current.y != '-1') {
    pathSteps.add(Steps(x: '${current.x}', y: '${current.y}'));
    current = Start(x: int.parse(steps[current.y!][current.x!].x!), y: int.parse(steps[current.y!][current.x!].y!));
  }
  pathSteps.add(Steps(x: '${start.x}', y: '${start.y}'));
  pathSteps = pathSteps.reversed.toList();

  String path = pathSteps.map((step) => "(${step.x},${step.y})").join("->");

  return ResultModel(id: '', result: Result(steps: pathSteps, path: path));
}
