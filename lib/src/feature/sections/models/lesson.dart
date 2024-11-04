class Lesson {
  final String id; // Уникальный идентификатор урока
  final String title; // Название урока (например, "Династия Тан")
  final String description; // Краткое описание урока
  final List<String> topics; // Список тем, охватываемых в уроке (например, культура, экономика)
  final String content; // Полный текст урока
  final bool isCompleted; // Статус прохождения урока (true, если пройден)
  final bool isBookmarked; // Статус закладки
  final List<String> highlightedTexts; // Список выделенных текстов для заметок
  final List<String> relatedDates; // Список связанных дат
  final List<String> relatedPeople; // Список связанных исторических личностей
  final List<String> relatedPlaces; // Список связанных мест
  

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.topics,
    required this.content,
    this.isCompleted = false,
    this.isBookmarked = false,
    this.highlightedTexts = const [],
    this.relatedDates = const [],
    this.relatedPeople = const [],
    this.relatedPlaces = const [],
  });
}
