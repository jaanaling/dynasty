part of 'lesson_bloc.dart';

sealed class LessonState extends Equatable {
  const LessonState();

  @override
  List<Object> get props => [];
}

final class LessonInitial extends LessonState {}

class LessonLoadedState extends LessonState {
  final List<LessonBlock> lesson;
  final List<HistoricalDate> date;
  final List<HistoricalEvent> event;
  final List<HistoricalFigure> figure;
  final List<HistoricalPlace> place;

  const LessonLoadedState({
    required this.lesson,
    required this.date,
    required this.event,
    required this.figure,
    required this.place,
  });

  @override
  List<Object> get props => [
        lesson,
        date,
        event,
        figure,
        place,
      ];
}
