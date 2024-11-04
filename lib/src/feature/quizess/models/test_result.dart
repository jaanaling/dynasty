// ignore_for_file: public_member_api_docs, sort_constructors_first
class TestResult {
  int totalScore;
  final int testId;


  TestResult({
    required this.testId,
    required this.totalScore,

  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'testId': testId,
      'totalScore': totalScore,

    };
  }

  factory TestResult.fromMap(Map<String, dynamic> map) {
    return TestResult(
      testId: map['testId'] as int,
      totalScore: map['totalScore'] as int,

    );
  }
}
