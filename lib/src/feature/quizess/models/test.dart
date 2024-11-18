// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dynasty_dive/src/feature/quizess/models/test_question.dart';

import 'package:flutter/foundation.dart';

class Test {
  final String id;
  final String title;
  final int dificulty;
  final String description;
  final List<TestQuestion> questions;
  final String category;
  bool isComplete;
  bool isOpen;
  int currentQuestionIndex;
  int totalScore;

  Test({
    required this.id,
    required this.title,
    required this.dificulty,
    required this.description,
    required this.questions,
    required this.category,
    this.isComplete = false,
    this.isOpen = false,
    this.currentQuestionIndex = 0,

    this.totalScore =0,
  });

 

  Test copyWith({
    String? id,
    String? title,
    int? dificulty,
    String? description,
    List<TestQuestion>? questions,
    String? category,
    bool? isComplete,
    bool? isOpen,
    int? currentQuestionIndex,
    int? totalScore,
  }) {
    return Test(
      id: id ?? this.id,
      title: title ?? this.title,
      dificulty: dificulty ?? this.dificulty,
      description: description ?? this.description,
      questions: questions ?? this.questions,
      category: category ?? this.category,
      isComplete: isComplete ?? this.isComplete,
      isOpen: isOpen ?? this.isOpen,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      totalScore: totalScore ?? this.totalScore,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'dificulty': dificulty,
      'description': description,
      'questions': questions.map((x) => x.toMap()).toList(),
      'category': category,
      'isComplete': isComplete,
      'isOpen': isOpen,

      'currentQuestionIndex': currentQuestionIndex,
      'totalScore': totalScore,
    };
  }

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      id: map['id'] as String,
      title: map['title'] as String,
      dificulty: map['dificulty'] as int,
      description: map['description'] as String,
      questions: List<TestQuestion>.from((map['questions'] as List<dynamic>).map<TestQuestion>((x) => TestQuestion.fromMap(x as Map<String,dynamic>),),),
      category: map['category'] as String,
      isComplete: map['isComplete'] != null ? map['isComplete'] as bool : false,
      isOpen: map['isOpen'] != null ? map['isOpen'] as bool : false,
      currentQuestionIndex:map['currentQuestionIndex'] != null ? map['currentQuestionIndex'] as int : 0,
      totalScore: map['totalScore'] != null ?map['totalScore'] as int : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Test.fromJson(String source) => Test.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PsychologicalTest(id: $id, title: $title, dificulty: $dificulty, description: $description, questions: $questions, category: $category,  isComplete: $isComplete, isOpen: $isOpen, currentQuestionIndex: $currentQuestionIndex, result: $totalScore)';
  }

  @override
  bool operator ==(covariant Test other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.dificulty == dificulty &&
      other.description == description &&
      listEquals(other.questions, questions) &&
      other.category == category &&
      other.isComplete == isComplete &&

      other.isOpen == isOpen &&
      other.currentQuestionIndex == currentQuestionIndex &&
      other.totalScore == totalScore;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^

      dificulty.hashCode ^
      description.hashCode ^
      questions.hashCode ^
      category.hashCode ^
      isComplete.hashCode ^
      isOpen.hashCode ^
      currentQuestionIndex.hashCode ^
      totalScore.hashCode;
  }
}
