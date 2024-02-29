class TaskModel {
  bool? error;
  String? message;
  List<Data>? data;

  TaskModel({required this.error, required this.message, required this.data});

  TaskModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  List<String>? field;
  Start? start;
  Start? end;

  Data({this.id, this.field, this.start, this.end});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    field = json['field'].cast<String>();
    start = json['start'] != null ? new Start.fromJson(json['start']) : null;
    end = json['end'] != null ? new Start.fromJson(json['end']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['field'] = this.field;
    if (this.start != null) {
      data['start'] = this.start!.toJson();
    }
    if (this.end != null) {
      data['end'] = this.end!.toJson();
    }
    return data;
  }
}

class Start {
  int? x;
  int? y;

  Start({this.x, this.y});

  Start.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}
