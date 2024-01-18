class Task {
  final String id;
  final String title;
  final String status;
  final String description;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.status,
    required this.description,
    required this.createdAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
