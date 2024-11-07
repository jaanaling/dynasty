import 'package:dynasty_dive/routes/route_value.dart';
import 'package:dynasty_dive/src/feature/lesson/bloc/lesson_bloc.dart';
import 'package:dynasty_dive/src/feature/quizess/bloc/test_bloc.dart';
import 'package:dynasty_dive/ui_kit/app_tile.dart';
import 'package:dynasty_dive/ui_kit/lesson_tile/lesson_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class SectionsScreen extends StatelessWidget {
  const SectionsScreen({super.key});

  // Создаём список GlobalKey для кнопок
  List<GlobalKey> generateGlobalKeys(int count) {
    return List.generate(count, (index) => GlobalKey());
  }

  Future<void> share(String name, GlobalKey shareButtonKey) async {
    await Share.share(
      '''
Hey! 🎉 I just made some progress on my lesson "$name" and I'm getting closer to finishing it! Just a bit more to go before the next stage. Join in if you want – it’d be more fun together! 💪😊''',
      subject: 'Look in my progress!',
      sharePositionOrigin: shareButtonRect(shareButtonKey),
    );
  }

  Rect? shareButtonRect(GlobalKey shareButtonKey) {
    RenderBox? renderBox =
        shareButtonKey.currentContext!.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;

    Size size = renderBox.size;
    Offset position = renderBox.localToGlobal(Offset.zero);

    return Rect.fromCenter(
      center: position + Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestBloc, TestState>(
      builder: (context, state1) {
        return BlocBuilder<LessonBloc, LessonState>(
          builder: (context, state) {
            if (state is LessonLoadedState) {
              // Генерация уникальных GlobalKey для каждого элемента списка

              return state1 is TestLoadedState
                  ? SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 120),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 34),
                              child: Text(
                                'Dynasty Dive',
                                style: TextStyle(
                                  fontSize: 24,
                                  height: 0,
                                ),
                              ),
                            ),
                            Gap(23),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.lesson.length,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Gap(18),
                              itemBuilder: (context, index) {
                                return LessonTile(
                                  // Используем уникальный GlobalKey для каждого элемента
                                  title: state.lesson[index].title,
                                  onShare: share,
                                  onStart: () => context.push(
                                    "${RouteValue.sections.path}/${RouteValue.lessons.path}",
                                    extra: state.lesson[index],
                                  ),
                                  completedLessons:
                                      state.lesson[index].completedLessonsCount,
                                  lessonsCount:
                                      state.lesson[index].lessons.length,
                                  completedQuiz: (state1 as TestLoadedState)
                                      .tests
                                      .where((test) => state
                                          .lesson[index].quizzesId
                                          .contains(test.id))
                                      .where((test) => test.isComplete).toList().length
                                   ,
                                  quizCount:
                                      state.lesson[index].quizzesId.length,
                                  score: (state1 as TestLoadedState)
                                      .tests
                                      .where((test) => state
                                          .lesson[index].quizzesId
                                          .contains(test.id))
                                      .fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue +
                                              (element.result?.totalScore ??
                                                  0)),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: CupertinoActivityIndicator(
                        color: Color(0xFFDF3E3E),
                      ),
                    );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}
