import 'dart:convert';
import 'package:dynasty_dive/src/core/utils/json_loader.dart';
import 'package:dynasty_dive/src/feature/lesson/models/lesson_bloc.dart';
import 'package:dynasty_dive/src/feature/quizess/models/test.dart';
import 'package:dynasty_dive/src/feature/quizess/models/test_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestRepository {
  Future<void> saveUserTests(List<Test> tests) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String encodedTests = jsonEncode(
      tests.map((test) => test.toMap()).toList(),
    );
    await prefs.setString('tests', encodedTests);
  }

  Future<List<Test>> getAllTests() async {
    return JsonLoader.loadData<Test>(
      'tests',
      'assets/json/quiz.json',
      (json) => Test.fromMap(json),
    );
  }

  Future<void> saveUserTestResult(int testId, int score) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final result = TestResult(
      totalScore: score,
      testId: testId,
    );

    final List<Test> allTests = await getAllTests();

    for (var test in allTests) {
      if (int.parse(test.id) == testId) {
        test.isComplete = true;
        test.result = result;
        break;
      }
    }

    final String updatedTestsJson = jsonEncode(
      allTests.map((test) => test.toMap()).toList(),
    );
    await prefs.setString('tests', updatedTestsJson);
  }

  Future<void> updateTestProgress(int testId, int selectedAnswerScore) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Test> allTests = await getAllTests();

    for (var test in allTests) {
      if (int.parse(test.id) == testId) {
        if (test.result != null) {
          test.result!.totalScore += selectedAnswerScore;
        } else {
          test.result = TestResult(
            totalScore: selectedAnswerScore,
            testId: testId,
          );
        }

        test.currentQuestionIndex = test.currentQuestionIndex + 1;

        break;
      }
    }

    final String updatedTestsJson = jsonEncode(
      allTests.map((test) => test.toMap()).toList(),
    );
    await prefs.setString('tests', updatedTestsJson);
  }

  Future<void> resetTest(int testId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Test> allTests = await getAllTests();

    for (var test in allTests) {
      if (int.parse(test.id) == testId) {
        test.currentQuestionIndex = 0;
        test.result = null;
        test.isComplete = false;
        break;
      }
    }

    final String updatedTestsJson = jsonEncode(
      allTests.map((test) => test.toMap()).toList(),
    );
    await prefs.setString('tests', updatedTestsJson);
  }
}
