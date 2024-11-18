part of 'test_bloc.dart';

abstract class TestState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TestInitial extends TestState {}

class TestLoadedState extends TestState {
  final List<Test> tests;
  final Test? currentTest;

  TestLoadedState({
    required this.tests,
    this.currentTest,
  });

  TestLoadedState copyWith({
    List<Test>? tests,
    Test? currentTest,
  }) {
    return TestLoadedState(
      tests: tests ?? this.tests,
      currentTest: currentTest ?? this.currentTest,
    );
  }

  @override
  List<Object?> get props => [
        tests,
        currentTest ?? [],
      ];
}
