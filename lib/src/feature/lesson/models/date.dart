// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class HistoricalDate {
  final String id; 
  final String? date;
  final String? description; 
  final List<String>? relatedPeople;
  final List<String>? relatedPlaces;
  final List<String>? relatedEvents;

  HistoricalDate({
    required this.id,
    required this.date,
    required this.description,
    this.relatedPeople = const [],
    this.relatedPlaces = const [],
    this.relatedEvents = const [],
  });

  HistoricalDate copyWith({
    String? id,
    String? date,
    String? description,
    List<String>? relatedPeople,
    List<String>? relatedPlaces,
    List<String>? relatedEvents,
  }) {
    return HistoricalDate(
      id: id ?? this.id,
      date: date ?? this.date,
      description: description ?? this.description,
      relatedPeople: relatedPeople ?? this.relatedPeople,
      relatedPlaces: relatedPlaces ?? this.relatedPlaces,
      relatedEvents: relatedEvents ?? this.relatedEvents,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'description': description,
      'relatedPeople': relatedPeople,
      'relatedPlaces': relatedPlaces,
      'relatedEvents': relatedEvents,
    };
  }

  factory HistoricalDate.fromMap(Map<String, dynamic> map) {
    return HistoricalDate(
      id: map['id'] as String,
      date: map['date'] != null ? map['date'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      relatedPeople: map['relatedPeople'] != null ? List<String>.from(map['relatedPeople'] as List<String>) : null,
      relatedPlaces: map['relatedPlaces'] != null ? List<String>.from(map['relatedPlaces'] as List<String>) : null,
      relatedEvents: map['relatedEvents'] != null ? List<String>.from(map['relatedEvents'] as List<String>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoricalDate.fromJson(String source) => HistoricalDate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HistoricalDate(id: $id, date: $date, description: $description, relatedPeople: $relatedPeople, relatedPlaces: $relatedPlaces, relatedEvents: $relatedEvents)';
  }

  @override
  bool operator ==(covariant HistoricalDate other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.date == date &&
      other.description == description &&
      listEquals(other.relatedPeople, relatedPeople) &&
      listEquals(other.relatedPlaces, relatedPlaces) &&
      listEquals(other.relatedEvents, relatedEvents);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      date.hashCode ^
      description.hashCode ^
      relatedPeople.hashCode ^
      relatedPlaces.hashCode ^
      relatedEvents.hashCode;
  }
}
