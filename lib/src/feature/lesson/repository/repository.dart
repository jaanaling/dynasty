import 'package:dynasty_dive/src/core/utils/json_loader.dart';
import 'package:dynasty_dive/src/feature/lesson/models/date.dart';
import 'package:dynasty_dive/src/feature/lesson/models/event.dart';
import 'package:dynasty_dive/src/feature/lesson/models/figure.dart';
import 'package:dynasty_dive/src/feature/lesson/models/lesson_bloc.dart';
import 'package:dynasty_dive/src/feature/lesson/models/place.dart';

class LessonRepository {
  Future<List<LessonBlock>> loadLessons() {
    return JsonLoader.loadData<LessonBlock>(
      'lesson',
      'assets/json/lessons.json',
      (json) => LessonBlock.fromMap(json),
    );
  }

  Future<void> updateLessons(LessonBlock updatedLesson) async {
    return JsonLoader.modifyDataList<LessonBlock>(
      'diary',
      updatedLesson,
      () async =>
          await loadLessons(), // Теперь это корректно возвращает Future<List<LessonBlock>>
      (lesson) => lesson.toMap(),
      (itemList) async {
        final index = itemList.indexWhere((d) => d.id == updatedLesson.id);
        if (index != -1) {
          itemList[index] = updatedLesson; // Обновляем элемент
        }
      },
    );
  }

  Future<List<HistoricalDate>> loadDate() {
    return JsonLoader.loadData<HistoricalDate>(
      'date',
      'assets/json/date.json',
      (json) => HistoricalDate.fromMap(json),
    );
  }

  Future<List<HistoricalEvent>> loadEvents() {
    return JsonLoader.loadData<HistoricalEvent>(
      'event',
      'assets/json/event.json',
      (json) => HistoricalEvent.fromMap(json),
    );
  }

  Future<List<HistoricalFigure>> loadFigures() {
    return JsonLoader.loadData<HistoricalFigure>(
      'figure',
      'assets/json/persons.json',
      (json) => HistoricalFigure.fromMap(json),
    );
  }

  Future<List<HistoricalPlace>> loadPlace() {
    return JsonLoader.loadData<HistoricalPlace>(
      'place',
      'assets/json/place.json',
      (json) => HistoricalPlace.fromMap(json),
    );
  }
}
