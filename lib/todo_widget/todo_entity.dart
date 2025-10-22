class ToDoEntity {
  final String title;
  final String? description;
  final bool isFavorite;
  final bool isDone;

  ToDoEntity({
    required this.title,
    this.description,
    this.isFavorite = false,
    this.isDone = false,
  });

  // ToDo 상태 변경을 위한 copyWith 메서드
  ToDoEntity copyWith({
    String? title,
    String? description,
    bool? isFavorite,
    bool? isDone,
  }) {
    return ToDoEntity(
      title: title ?? this.title,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      isDone: isDone ?? this.isDone,
    );
  }
}