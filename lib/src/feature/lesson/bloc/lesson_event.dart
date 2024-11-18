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
  final BuildContext context;

  const CompliteLessonEvent({
    required this.lessonBlock,
    required this.lessonId,
    required this.context,
    this.tests,
  });

  @override
  List<Object> get props => [lessonBlock, lessonId, tests ?? []];
}

class SwitchedBookmarkedLessonEvent extends LessonEvent {
  final LessonBlock lessonBlock;
  final String? lessonId;

  const SwitchedBookmarkedLessonEvent({
    required this.lessonBlock,
     this.lessonId,
  });
  @override
  List<Object> get props => [
        lessonBlock,
        lessonId ?? '',
      ];
}
