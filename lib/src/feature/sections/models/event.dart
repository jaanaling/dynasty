class HistoricalEvent {
  final String id; // Уникальный идентификатор события
  final String title; // Название события
  final String description; // Краткое описание события
  final DateTime date; // Основная дата события
  final List<String> relatedDates; // Другие важные даты, связанные с событием
  final List<String> relatedPeople; // Личности, связанные с событием
  final List<String> relatedPlaces; // Места, связанные с событием

  HistoricalEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.relatedDates = const [],
    this.relatedPeople = const [],
    this.relatedPlaces = const [],

  });
}