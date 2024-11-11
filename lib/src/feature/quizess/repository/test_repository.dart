import 'dart:convert';
import 'package:dynasty_dive/src/core/utils/json_loader.dart';
import 'package:dynasty_dive/src/feature/lesson/models/lesson_bloc.dart';
import 'package:dynasty_dive/src/feature/quizess/models/test.dart';
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

  Future<void> saveUserTestResult(Test testId, int score) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Test> allTests = await getAllTests();

    testId.isComplete = true;
    final String updatedTestsJson = jsonEncode(
      allTests.map((test) => test.toMap()).toList(),
    );
    await prefs.setString('tests', updatedTestsJson);
  }

  Future<void> updateTestProgress(
      String testId, int selectedAnswerScore) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Test> allTests = await getAllTests();

    for (var test in allTests) {
      if (test.id == testId) {
        test.totalScore += selectedAnswerScore;
      }

      test.currentQuestionIndex = test.currentQuestionIndex + 1;

      break;
    }

    final String updatedTestsJson = jsonEncode(
      allTests.map((test) => test.toMap()).toList(),
    );
    await prefs.setString('tests', updatedTestsJson);
  }

  Future<void> resetTest(String testId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Test> allTests = await getAllTests();

    for (var test in allTests) {
      if (test.id == testId) {
        test.currentQuestionIndex = 0;
        test.totalScore = 0;
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
