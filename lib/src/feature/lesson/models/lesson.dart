// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Lesson {
  final String id; // Уникальный идентификатор урока
  final String title; // Название урока (например, "Династия Тан")
  final String description; // Краткое описание урока
  final List<String>? topics; // Список тем, охватываемых в уроке (например, культура, экономика)
  final String content; // Полный текст урока
   bool isCompleted; // Статус прохождения урока (true, если пройден)
   bool isBookmarked; // Статус закладки
  final List<String>? highlightedTexts; // Список выделенных текстов для заметок
  final List<String>? relatedDates; // Список связанных дат
  final List<String>? relatedPeople; // Список связанных исторических личностей
  final List<String>? relatedPlaces; // Список связанных мест
  

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

  Lesson copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? topics,
    String? content,
    bool? isCompleted,
    bool? isBookmarked,
    List<String>? highlightedTexts,
    List<String>? relatedDates,
    List<String>? relatedPeople,
    List<String>? relatedPlaces,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      topics: topics ?? this.topics,
      content: content ?? this.content,
      isCompleted: isCompleted ?? this.isCompleted,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      highlightedTexts: highlightedTexts ?? this.highlightedTexts,
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
      'topics': topics,
      'content': content,
      'isCompleted': isCompleted,
      'isBookmarked': isBookmarked,
      'highlightedTexts': highlightedTexts,
      'relatedDates': relatedDates,
      'relatedPeople': relatedPeople,
      'relatedPlaces': relatedPlaces,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      topics: map['topics'] != null ? List<String>.from(map['topics'] as List<String>) : null,
      content: map['content'] as String,
      isCompleted: map['isCompleted'] != null ? map['isCompleted'] as bool : false,
      isBookmarked: map['isBookmarked'] != null ? map['isBookmarked'] as bool : false,
      highlightedTexts: map['highlightedTexts'] != null ? List<String>.from(map['highlightedTexts'] as List<String>) : null,
      relatedDates: map['relatedDates'] != null ? List<String>.from(map['relatedDates'] as List<String>) : null,
      relatedPeople: map['relatedPeople'] != null ? List<String>.from(map['relatedPeople'] as List<String>) : null,
      relatedPlaces: map['relatedPlaces'] != null ? List<String>.from(map['relatedPlaces'] as List<String>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lesson.fromJson(String source) => Lesson.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Lesson(id: $id, title: $title, description: $description, topics: $topics, content: $content, isCompleted: $isCompleted, isBookmarked: $isBookmarked, highlightedTexts: $highlightedTexts, relatedDates: $relatedDates, relatedPeople: $relatedPeople, relatedPlaces: $relatedPlaces)';
  }

  @override
  bool operator ==(covariant Lesson other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      listEquals(other.topics, topics) &&
      other.content == content &&
      other.isCompleted == isCompleted &&
      other.isBookmarked == isBookmarked &&
      listEquals(other.highlightedTexts, highlightedTexts) &&
      listEquals(other.relatedDates, relatedDates) &&
      listEquals(other.relatedPeople, relatedPeople) &&
      listEquals(other.relatedPlaces, relatedPlaces);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      topics.hashCode ^
      content.hashCode ^
      isCompleted.hashCode ^
      isBookmarked.hashCode ^
      highlightedTexts.hashCode ^
      relatedDates.hashCode ^
      relatedPeople.hashCode ^
      relatedPlaces.hashCode;
  }
}
