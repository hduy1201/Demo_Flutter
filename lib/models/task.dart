class Task {
  int id;
  String content;
  String status;

  Task({required this.id, this.content = "", this.status = "To Do"});

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'status': status,
      };
}
