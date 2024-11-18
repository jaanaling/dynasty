// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class HistoricalFigure {
  final String id; // Уникальный идентификатор личности
  final String name; // Имя исторической личности
  final String? description; // Краткая биография
  final List<String>? relatedEvents; // События, связанные с личностью
  final List<String>? relatedDates; // Важные даты, связанные с личностью
  final List<String>? relatedPlaces; // Места, связанные с личностью
  final String? image;

  HistoricalFigure({
    required this.id,
    required this.name,
    required this.description,
    this.relatedEvents = const [],
    this.relatedDates = const [],
    this.relatedPlaces = const [],
    required this.image,
  });

  HistoricalFigure copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? relatedEvents,
    List<String>? relatedDates,
    List<String>? relatedPlaces,
    String? image,
  }) {
    return HistoricalFigure(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      relatedEvents: relatedEvents ?? this.relatedEvents,
      relatedDates: relatedDates ?? this.relatedDates,
      relatedPlaces: relatedPlaces ?? this.relatedPlaces,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'relatedEvents': relatedEvents,
      'relatedDates': relatedDates,
      'relatedPlaces': relatedPlaces,
      'image': image,
    };
  }

  factory HistoricalFigure.fromMap(Map<String, dynamic> map) {
    return HistoricalFigure(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      relatedEvents: map['relatedEvents'] != null ? List<String>.from(map['relatedEvents'] as List<dynamic>) : null,
      relatedDates: map['relatedDates'] != null ? List<String>.from(map['relatedDates'] as List<dynamic>) : null,
      relatedPlaces: map['relatedPlaces'] != null ? List<String>.from(map['relatedPlaces'] as List<dynamic>) : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoricalFigure.fromJson(String source) => HistoricalFigure.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HistoricalFigure(id: $id, name: $name, description: $description, relatedEvents: $relatedEvents, relatedDates: $relatedDates, relatedPlaces: $relatedPlaces, image: $image)';
  }

  @override
  bool operator ==(covariant HistoricalFigure other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      listEquals(other.relatedEvents, relatedEvents) &&
      listEquals(other.relatedDates, relatedDates) &&
      listEquals(other.relatedPlaces, relatedPlaces) &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      relatedEvents.hashCode ^
      relatedDates.hashCode ^
      relatedPlaces.hashCode ^
      image.hashCode;
  }
}
