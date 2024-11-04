class HistoricalPlace {
  final String id; // Уникальный идентификатор места
  final String name; // Название места
  final String description; // Описание места
  final List<String> relatedEvents; // События, связанные с местом
  final List<String> relatedPeople; // Личности, связанные с местом
  final List<String> relatedDates; // Даты, связанные с местом
  final String? mapLocation; // Координаты или ссылка на карту

  HistoricalPlace({
    required this.id,
    required this.name,
    required this.description,
    this.relatedEvents = const [],
    this.relatedPeople = const [],
    this.relatedDates = const [],
    this.mapLocation,
  });
}
