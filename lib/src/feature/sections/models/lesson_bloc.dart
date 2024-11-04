import 'package:dynasty_dive/src/feature/sections/models/lesson.dart';

class LessonBlock {
  final String id;
  final String title;
  final String description;
  final List<Lesson> lessons;
  final int completedLessonsCount;
  final int completedQuizzesCount;
  final int earnedPoints;
  final bool isBookmarked;
  final List<String> quizzesId;

  LessonBlock({
    required this.quizzesId,
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
    this.completedLessonsCount = 0,
    this.completedQuizzesCount = 0,
    this.earnedPoints = 0,
    this.isBookmarked = false,
  });
}
