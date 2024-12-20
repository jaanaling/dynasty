import 'package:bloc/bloc.dart';
import 'package:dynasty_dive/src/core/dependency_injection.dart';
import 'package:dynasty_dive/src/feature/lesson/models/date.dart';
import 'package:dynasty_dive/src/feature/lesson/models/event.dart';
import 'package:dynasty_dive/src/feature/lesson/models/figure.dart';
import 'package:dynasty_dive/src/feature/lesson/models/lesson_bloc.dart';
import 'package:dynasty_dive/src/feature/lesson/models/place.dart';
import 'package:dynasty_dive/src/feature/quizess/bloc/test_bloc.dart';
import 'package:dynasty_dive/src/feature/quizess/models/test.dart';
import 'package:dynasty_dive/src/feature/quizess/repository/test_repository.dart';
import 'package:dynasty_dive/src/feature/lesson/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final LessonRepository repository = locator<LessonRepository>();
  final TestRepository testRepository = locator<TestRepository>();

  LessonBloc() : super(LessonInitial()) {
    on<LoadLessonEvent>((event, emit) async {
      final lessons = await repository.loadLessons();
      final date = await repository.loadDate();
      final events = await repository.loadEvents();
      final figure = await repository.loadFigures();
      final place = await repository.loadPlace();

      emit(LessonLoadedState(
        lesson: lessons,
        date: date,
        event: events,
        figure: figure,
        place: place,
      ));
    });

    on<SwitchedBookmarkedLessonEvent>((event, emit) async {
      if (event.lessonId == null) {
        event.lessonBlock.isBookmarked = !event.lessonBlock.isBookmarked;
        await repository.updateLessons(event.lessonBlock);
      } else {
        final lesson = event.lessonBlock.lessons.firstWhere(
          (lesson) => lesson.id == event.lessonId,
          orElse: () => throw Exception('Lesson not found'),
        );
        lesson.isBookmarked = !lesson.isBookmarked;
        await repository.updateLessons(event.lessonBlock);
      }

      final lessons = await repository.loadLessons();

      emit(LessonLoadedState(
        lesson: lessons,
        date: (state as LessonLoadedState).date,
        event: (state as LessonLoadedState).event,
        figure: (state as LessonLoadedState).figure,
        place: (state as LessonLoadedState).place,
      ));
    });
    on<CompliteLessonEvent>((event, emit) async {
      
      event.lessonBlock.completedLessonsCount++;

      event.lessonBlock.lessons
          .firstWhere((lesson) => lesson.id == event.lessonId)
          .isCompleted = true;
      if (event.tests != null &&
          event.tests!.isNotEmpty &&
          event.lessonBlock.quizzesId.isNotEmpty &&
          event.lessonBlock.completedLessonsCount ==
              event.lessonBlock.lessons.length) {
        for (var quizId in event.lessonBlock.quizzesId) {
          event.tests!.firstWhere((test) => test.id == quizId).isOpen = true;
          await testRepository.saveUserTests(event.tests!);
          event.context.read<TestBloc>().add(LoadTestsEvent());
        }
      }

      await repository.updateLessons(event.lessonBlock);

      final lessons = await repository.loadLessons();

      emit(LessonLoadedState(
        lesson: lessons,
        date: (state as LessonLoadedState).date,
        event: (state as LessonLoadedState).event,
        figure: (state as LessonLoadedState).figure,
        place: (state as LessonLoadedState).place,
      ));
    });
  }
}
