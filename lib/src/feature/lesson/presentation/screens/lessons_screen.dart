import 'package:dynasty_dive/routes/route_value.dart';
import 'package:dynasty_dive/src/feature/lesson/models/lesson_bloc.dart';
import 'package:dynasty_dive/ui_kit/app_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LessonsScreen extends StatelessWidget {
  final LessonBlock lessons;
  const LessonsScreen({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(17, 33, 17, 120),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                CupertinoButton(
                  child: Icon(CupertinoIcons.back),
                  onPressed: () => context.pop(),
                ),
                Gap(5),
                SizedBox(height: 53,
                  child: VerticalDivider(
                    width: 1,
                    color: Color(0xFF6D6D6D),
                    thickness: 1,
                  ),
                ),
                Gap(15),
                Text("Dynasty Dive",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      height: 0,
                    ))
              ],
            ),
            Gap(23),
            ListView.separated(
              itemCount: lessons.lessons.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => Gap(14),
              itemBuilder: (context, index) => AppTile(
                title: lessons.lessons[index].title,
                trailing: Icon(
                  CupertinoIcons.forward,
                  color: Colors.white,
                  size: 30,
                ),
                subtitle: Row(
                  children: [
                    Text( lessons.lessons[index].isCompleted
                          ? "Done"
                          : "In progress"),
                    Gap(7),
                    Icon(
                      lessons.lessons[index].isCompleted
                          ? CupertinoIcons.check_mark_circled_solid
                          : CupertinoIcons.check_mark_circled,
                    ),
                  ],
                ),
                onTap: () {
                  context.push(
                      "${RouteValue.sections.path}/${RouteValue.lessons.path}/${RouteValue.lesson.path}",
                      extra: {
                        "lessonId": lessons.lessons[index].id,
                        "lessonBlock": lessons
                      });
                },
                id: index,
                generateColor: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


