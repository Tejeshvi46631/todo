class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'] ?? false,
    );
  }

  static List<Todo> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Todo.fromJson(json)).toList();
  }
}
