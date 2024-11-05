part of 'lesson_bloc.dart';

sealed class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object> get props => [];
}

class LoadLessonEvent extends LessonEvent {
  const LoadLessonEvent();

  @override
  List<Object> get props => [];
}

class CompliteLessonEvent extends LessonEvent {
  final LessonBlock lessonBlock;
  final String lessonId;
  final List<Test>? tests;


  const CompliteLessonEvent({
    required this.lessonBlock,
    required this.lessonId,
    this.tests,
  });

  @override
  List<Object> get props => [lessonBlock, lessonId, tests ?? []];
}
