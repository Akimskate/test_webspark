import 'dart:collection';

import 'package:test_webspark/domain/model/result_model.dart';
import 'package:test_webspark/domain/model/task_model.dart';

ResultModel dijkstra(TaskModel? taskModel) {
  // Получаем данные из объекта TaskModel
  List<String>? field = taskModel?.data![1].field!;
  Start? start = taskModel?.data![1].start!;
  Start? end = taskModel?.data![1].end!;

  final int rows = field!.length;
  final int cols = field[0].length;

  List<List<int>> distance = List.generate(rows, (i) => List.filled(cols, 9999));
  List<List<Steps>> steps = List.generate(rows, (i) => List.filled(cols, Steps(x: '-1', y: '-1')));

  Queue<Start> queue = Queue();

  distance[start!.y!][start.x!] = 0;
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
      Start(x: x - 1, y: y - 1), // Верхняя левая
      Start(x: x + 1, y: y - 1), // Верхняя правая
      Start(x: x - 1, y: y + 1), // Нижняя левая
      Start(x: x + 1, y: y + 1), // Нижняя правая
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
  Start? current = end;
  while (current?.x != -1 && current?.y != -1) {
    pathSteps.add(Steps(x: '${current?.x}', y: '${current?.y}'));
    if (current != null && current.x != null && current.y != null) {
      int nx = current.x!;
      int ny = current.y!;
      if (nx >= 0 && nx < cols && ny >= 0 && ny < rows) {
        current = Start(
          x: int.parse(steps[ny][nx].x.toString()),
          y: int.parse(steps[ny][nx].y.toString()),
        );
      } else {
        break;
      }
    } else {
      break;
    }
  }
  pathSteps.add(Steps(x: '${end?.x}', y: '${end?.y}'));
  //pathSteps = pathSteps.reversed.toList();

  String path = pathSteps.map((step) => "(${step.x},${step.y})").join("->");

  return ResultModel(id: '', result: Result(steps: pathSteps, path: path));
}
