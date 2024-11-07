import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class LessonTile extends StatelessWidget {
  final String title;
  final Future<void> Function(String, GlobalKey<State<StatefulWidget>>) onShare;
  final VoidCallback onStart;
  final int completedLessons;
  final int lessonsCount;
  final int completedQuiz;
  final int quizCount;
  final int score;

  const LessonTile(
      {super.key,
      required this.title,
      required this.onShare,
      required this.onStart,
      required this.completedLessons,
      required this.lessonsCount,
      required this.completedQuiz,
      required this.quizCount,
      required this.score});

  @override
  Widget build(BuildContext context) {
    final GlobalKey key = GlobalKey();
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16, right: 0),
          child: Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(1.00, -0.09),
                end: Alignment(-1, 0.09),
                colors: [Color(0xFFDF3E3E), Color(0xFFAC2A2A)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(21),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 7),
                              child: Text(
                                title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Stetica',
                                  shadows: [
                                    Shadow(
                                      color: Colors.black
                                          .withOpacity(0.5), // Цвет тени
                                      offset: Offset(2.0, 2.0), // Смещение тени
                                      blurRadius: 4.0, // Размытие тени
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Gap(6),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 7, right: 17),
                              child: Divider(
                                color: Colors.white,
                              ),
                            ),
                            Gap(4),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    new CircularPercentIndicator(
                                      radius: 28.5,
                                      lineWidth: 5.0,
                                      percent: completedLessons / lessonsCount,
                                      center: Text(
                                        completedLessons.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Stetica',
                                          shadows: [
                                            Shadow(
                                              color: Colors.black.withOpacity(
                                                  0.5), // Цвет тени
                                              offset: Offset(
                                                  2.0, 2.0), // Смещение тени
                                              blurRadius: 4.0, // Размытие тени
                                            ),
                                          ],
                                        ),
                                      ),
                                      progressColor: Color(0xFF4DFF62),
                                      backgroundColor: Colors.black
                                          .withOpacity(0.38999998569488525),
                                    ),
                                    Gap(4),
                                    Text(
                                      'lessons',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'Stetica',
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(27),
                                Column(
                                  children: [
                                    new CircularPercentIndicator(
                                      radius: 28.5,
                                      lineWidth: 5.0,
                                      percent: completedQuiz / quizCount,
                                      center: Text(
                                        completedQuiz.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Stetica',
                                          shadows: [
                                            Shadow(
                                              color: Colors.black.withOpacity(
                                                  0.5), // Цвет тени
                                              offset: Offset(
                                                  2.0, 2.0), // Смещение тени
                                              blurRadius: 4.0, // Размытие тени
                                            ),
                                          ],
                                        ),
                                      ),
                                      progressColor: Color(0xFF4DFF62),
                                      backgroundColor: Colors.black
                                          .withOpacity(0.38999998569488525),
                                    ),
                                    Gap(4),
                                    Text(
                                      'Quiz',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'Stetica',
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Total points:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Stetica',
                                height: 0,
                              ),
                            ),
                            Text(
                              score.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Stetica',
                                shadows: [
                                  Shadow(
                                    color: Colors.black
                                        .withOpacity(0.5), // Цвет тени
                                    offset: Offset(2.0, 2.0), // Смещение тени
                                    blurRadius: 4.0, // Размытие тени
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CupertinoButton(
            onPressed: onStart,
            padding: EdgeInsets.zero,
            child: Container(
              width: 60,
              height: 60,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 43,
                    top: 12,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(1.57),
                      child: Container(
                        width: 36,
                        height: 25,
                        decoration: ShapeDecoration(
                          color: Color(0xFFDF3E3E),
                          shape: StarBorder.polygon(
                            sides: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 2,
            right: 17,
            child: CupertinoButton(
                key: key,
                onPressed: () async => await onShare(title, key),
                padding: EdgeInsets.zero,
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                )))
      ],
    );
  }
}
