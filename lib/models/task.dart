class Task {
  final int id;
  final String name;
  final String description;
  final int priority;
  String status;
  final String filePath;
  final String created_at;
  final String updated_at;
  final String dueDate;
  final String dueTime;

  Task(
      {required this.id,
      required this.name,
      required this.description,
      required this.priority,
      required this.status,
      required this.filePath,
      required this.dueDate,
      required this.dueTime,
      required this.created_at,
      required this.updated_at});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        priority: json['priority'],
        status: json['status'],
        filePath: json['filePath'],
        dueDate: json['dueDate'],
        dueTime: json['dueTime'],
        created_at: json['created_at'],
        updated_at: json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'priority': priority,
      'status': status,
      'filePath': filePath,
      'created_at': created_at,
      'updated_at': updated_at
    };
  }
}
