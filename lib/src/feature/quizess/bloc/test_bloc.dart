import 'package:bloc/bloc.dart';
import 'package:dynasty_dive/routes/route_value.dart';
import 'package:dynasty_dive/src/core/dependency_injection.dart';
import 'package:dynasty_dive/src/core/utils/log.dart';
import 'package:dynasty_dive/src/feature/quizess/models/test.dart';
import 'package:dynasty_dive/src/feature/quizess/repository/test_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final TestRepository testRepository = locator<TestRepository>();

  TestBloc() : super(TestInitial()) {
    on<LoadTestsEvent>(_onLoadTests);
    on<SubmitAnswerEvent>(_onSubmitAnswer);
    on<SetCurrentTestEvent>(_onSetCurrentTest);
    on<ResetTestEvent>(_onResetTest);
  }

  Future<void> _onLoadTests(
    LoadTestsEvent event,
    Emitter<TestState> emit,
  ) async {
    final tests = await testRepository.getAllTests();

    emit(
      TestLoadedState(
        tests: tests,
      ),
    );
  }

  Future<void> _onSubmitAnswer(
    SubmitAnswerEvent event,
    Emitter<TestState> emit,
  ) async {
    final state = this.state as TestLoadedState;

    final tests = state.tests;
    final currentTest = event.curTest;

    final currentIndex = currentTest.currentQuestionIndex + 1;
logger.d( "$currentIndex index");
    // Обновляем прогресс теста и добавляем очки
    await testRepository.updateTestProgress(
      currentTest.id,
      event.score,
    );
  
    if (currentIndex < currentTest.questions.length) {
      final updatedTest = currentTest.copyWith(
        currentQuestionIndex: currentIndex,
      );
 

      emit(
        TestLoadedState(
          tests: tests,
          currentTest: updatedTest,
        ),
      );
    } else {
      // Сохраняем результат по завершении теста
      await testRepository.saveUserTestResult(
        currentTest,
        event.score,
      );

      final tests = await testRepository.getAllTests();

      event.context.pushReplacement(
        '${RouteValue.quizess.path}/${RouteValue.quizResult.path}',
        extra: tests.firstWhere(
          (test) => test.id == currentTest.id,
        ),
      );

      emit(
        TestLoadedState(
          currentTest: tests.firstWhere(
            (test) => test.id == currentTest.id,
          ),
          tests: tests,
        ),
      );
    }
    }

  Future<void> _onSetCurrentTest(
    SetCurrentTestEvent event,
    Emitter<TestState> emit,
  ) async {
    final state = this.state as TestLoadedState;
    final tests = await testRepository.getAllTests();
    emit(
      state.copyWith(
        tests: tests,
        currentTest: tests.firstWhere((test) => test.id == event.test.id),
      ),
    );
  }

  Future<void> _onResetTest(
    ResetTestEvent event,
    Emitter<TestState> emit,
  ) async {
    await testRepository.resetTest(event.test.id);

    final tests = await testRepository.getAllTests();

    event.context.pushReplacement(
      "${RouteValue.quizess.path}/${RouteValue.quiz.path}",
      extra: event.test,
    );

    emit(
      TestLoadedState(
        tests: tests,
        currentTest: tests.firstWhere(
          (test) => test.id == event.test.id,
        ),
      ),
    );
  }
}
