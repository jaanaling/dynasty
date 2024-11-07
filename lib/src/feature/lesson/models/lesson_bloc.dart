// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dynasty_dive/src/feature/lesson/models/lesson.dart';

class LessonBlock {
  final String id;
  final String title;
  final String description;
  final List<Lesson> lessons;
   int completedLessonsCount;
   int completedQuizzesCount;
   int earnedPoints;
   bool isBookmarked;
  final List<String> quizzesId;

  LessonBlock({
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
    this.completedLessonsCount = 0,
    this.completedQuizzesCount = 0,
    this.earnedPoints = 0,
    this.isBookmarked = false,
    required this.quizzesId,
  });

  LessonBlock copyWith({
    String? id,
    String? title,
    String? description,
    List<Lesson>? lessons,
    int? completedLessonsCount,
    int? completedQuizzesCount,
    int? earnedPoints,
    bool? isBookmarked,
    List<String>? quizzesId,
  }) {
    return LessonBlock(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      lessons: lessons ?? this.lessons,
      completedLessonsCount: completedLessonsCount ?? this.completedLessonsCount,
      completedQuizzesCount: completedQuizzesCount ?? this.completedQuizzesCount,
      earnedPoints: earnedPoints ?? this.earnedPoints,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      quizzesId: quizzesId ?? this.quizzesId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'lessons': lessons.map((x) => x.toMap()).toList(),
      'completedLessonsCount': completedLessonsCount,
      'completedQuizzesCount': completedQuizzesCount,
      'earnedPoints': earnedPoints,
      'isBookmarked': isBookmarked,
      'quizzesId': quizzesId,
    };
  }

  factory LessonBlock.fromMap(Map<String, dynamic> map) {
    return LessonBlock(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      lessons: List<Lesson>.from((map['lessons'] as List<dynamic>).map<Lesson>((x) => Lesson.fromMap(x as Map<String,dynamic>),),),
      completedLessonsCount:  map['completedLessonsCount'] != null ? map['completedLessonsCount'] as int : 0,
      completedQuizzesCount: map['completedQuizzesCount'] != null ? map['completedQuizzesCount'] as int : 0,
      earnedPoints: map['earnedPoints'] != null ?map['earnedPoints'] as int : 0,
      isBookmarked: map['isBookmarked'] != null? map['isBookmarked'] as bool : false,
      quizzesId: List<String>.from(map['quizzesId'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory LessonBlock.fromJson(String source) => LessonBlock.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LessonBlock(id: $id, title: $title, description: $description, lessons: $lessons, completedLessonsCount: $completedLessonsCount, completedQuizzesCount: $completedQuizzesCount, earnedPoints: $earnedPoints, isBookmarked: $isBookmarked, quizzesId: $quizzesId)';
  }

  @override
  bool operator ==(covariant LessonBlock other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      listEquals(other.lessons, lessons) &&
      other.completedLessonsCount == completedLessonsCount &&
      other.completedQuizzesCount == completedQuizzesCount &&
      other.earnedPoints == earnedPoints &&
      other.isBookmarked == isBookmarked &&
      listEquals(other.quizzesId, quizzesId);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      lessons.hashCode ^
      completedLessonsCount.hashCode ^
      completedQuizzesCount.hashCode ^
      earnedPoints.hashCode ^
      isBookmarked.hashCode ^
      quizzesId.hashCode;
  }
}
