// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class HistoricalPlace {
  final String id; // Уникальный идентификатор места
  final String name; // Название места
  final String description; // Описание места
  final List<String>? relatedEvents; // События, связанные с местом
  final List<String>? relatedPeople; // Личности, связанные с местом
  final List<String>? relatedDates; // Даты, связанные с местом
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

  HistoricalPlace copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? relatedEvents,
    List<String>? relatedPeople,
    List<String>? relatedDates,
    String? mapLocation,
  }) {
    return HistoricalPlace(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      relatedEvents: relatedEvents ?? this.relatedEvents,
      relatedPeople: relatedPeople ?? this.relatedPeople,
      relatedDates: relatedDates ?? this.relatedDates,
      mapLocation: mapLocation ?? this.mapLocation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'relatedEvents': relatedEvents,
      'relatedPeople': relatedPeople,
      'relatedDates': relatedDates,
      'mapLocation': mapLocation,
    };
  }

  factory HistoricalPlace.fromMap(Map<String, dynamic> map) {
    return HistoricalPlace(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      relatedEvents: map['relatedEvents'] != null ? List<String>.from(map['relatedEvents'] as List<dynamic>) : null,
      relatedPeople: map['relatedPeople'] != null ? List<String>.from(map['relatedPeople'] as List<dynamic>) : null,
      relatedDates: map['relatedDates'] != null ? List<String>.from(map['relatedDates'] as List<dynamic>) : null,
      mapLocation: map['mapLocation'] != null ? map['mapLocation'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoricalPlace.fromJson(String source) => HistoricalPlace.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HistoricalPlace(id: $id, name: $name, description: $description, relatedEvents: $relatedEvents, relatedPeople: $relatedPeople, relatedDates: $relatedDates, mapLocation: $mapLocation)';
  }

  @override
  bool operator ==(covariant HistoricalPlace other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      listEquals(other.relatedEvents, relatedEvents) &&
      listEquals(other.relatedPeople, relatedPeople) &&
      listEquals(other.relatedDates, relatedDates) &&
      other.mapLocation == mapLocation;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      relatedEvents.hashCode ^
      relatedPeople.hashCode ^
      relatedDates.hashCode ^
      mapLocation.hashCode;
  }
}
