// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class HistoricalEvent {
  final String id; // Уникальный идентификатор события
  final String title; // Название события
  final String description; // Краткое описание события
  final DateTime? date; // Основная дата события
  final List<String>? relatedDates; // Другие важные даты, связанные с событием
  final List<String>? relatedPeople; // Личности, связанные с событием
  final List<String>? relatedPlaces; // Места, связанные с событием

  HistoricalEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.relatedDates = const [],
    this.relatedPeople = const [],
    this.relatedPlaces = const [],

  });

  HistoricalEvent copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    List<String>? relatedDates,
    List<String>? relatedPeople,
    List<String>? relatedPlaces,
  }) {
    return HistoricalEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      relatedDates: relatedDates ?? this.relatedDates,
      relatedPeople: relatedPeople ?? this.relatedPeople,
      relatedPlaces: relatedPlaces ?? this.relatedPlaces,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'date': date?.millisecondsSinceEpoch,
      'relatedDates': relatedDates,
      'relatedPeople': relatedPeople,
      'relatedPlaces': relatedPlaces,
    };
  }

  factory HistoricalEvent.fromMap(Map<String, dynamic> map) {
    return HistoricalEvent(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      date: map['date'] != null ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int) : null,
      relatedDates: map['relatedDates'] != null ? List<String>.from(map['relatedDates'] as List<String>) : null,
      relatedPeople: map['relatedPeople'] != null ? List<String>.from(map['relatedPeople'] as List<String>) : null,
      relatedPlaces: map['relatedPlaces'] != null ? List<String>.from(map['relatedPlaces'] as List<String>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoricalEvent.fromJson(String source) => HistoricalEvent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HistoricalEvent(id: $id, title: $title, description: $description, date: $date, relatedDates: $relatedDates, relatedPeople: $relatedPeople, relatedPlaces: $relatedPlaces)';
  }

  @override
  bool operator ==(covariant HistoricalEvent other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.date == date &&
      listEquals(other.relatedDates, relatedDates) &&
      listEquals(other.relatedPeople, relatedPeople) &&
      listEquals(other.relatedPlaces, relatedPlaces);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      date.hashCode ^
      relatedDates.hashCode ^
      relatedPeople.hashCode ^
      relatedPlaces.hashCode;
  }
}
