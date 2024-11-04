class HistoricalDate {
  final String id; // Уникальный идентификатор даты
  final DateTime date; // Дата события
  final String description; // Описание события
  final List<String> relatedPeople; // Список связанных личностей
  final List<String> relatedPlaces; // Список связанных мест
  final List<String> relatedEvents; // Другие события, связанные с этой датой

  HistoricalDate({
    required this.id,
    required this.date,
    required this.description,
    this.relatedPeople = const [],
    this.relatedPlaces = const [],
    this.relatedEvents = const [],
  });
}
