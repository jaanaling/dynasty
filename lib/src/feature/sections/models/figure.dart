class HistoricalFigure {
  final String id; // Уникальный идентификатор личности
  final String name; // Имя исторической личности
  final String bio; // Краткая биография
  final DateTime birthDate; // Дата рождения
  final DateTime? deathDate; // Дата смерти (может быть null)
  final List<String> relatedEvents; // События, связанные с личностью
  final List<String> relatedDates; // Важные даты, связанные с личностью
  final List<String> relatedPlaces; // Места, связанные с личностью
  final String? imageUrl;

  HistoricalFigure({
    required this.id,
    required this.name,
    required this.bio,
    required this.birthDate,
    required this.imageUrl,
    this.deathDate,
    this.relatedEvents = const [],
    this.relatedDates = const [],
    this.relatedPlaces = const [],
  });
}
