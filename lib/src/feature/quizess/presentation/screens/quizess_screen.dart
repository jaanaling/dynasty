import 'package:dynasty_dive/routes/route_value.dart';
import 'package:dynasty_dive/src/feature/quizess/bloc/test_bloc.dart';
import 'package:dynasty_dive/ui_kit/app_tile.dart';
import 'package:dynasty_dive/ui_kit/cupertino_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class QuizessScreen extends StatelessWidget {
  const QuizessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestBloc, TestState>(
      builder: (context, state) {
        return state is TestLoadedState
            ? ListView.separated(
                separatorBuilder: (context, index) => const Gap(14),
                shrinkWrap: true,
                itemCount: state.tests.length,
                padding:
                    EdgeInsets.only(bottom: 140, top: 80, left: 17, right: 17),
                itemBuilder: (context, index) {
                  return AppTile(
                    onTap: () {
                      context
                          .read<TestBloc>()
                          .add(SetCurrentTestEvent(state.tests[index]));
                      state.tests[index].isOpen
                          ? state.tests[index].isComplete
                              ? context.push(
                                  '${RouteValue.quizess.path}/${RouteValue.quizResult.path}',
                                  extra: state.tests[index],
                                )
                              : context.push(
                                  '${RouteValue.quizess.path}/${RouteValue.quiz.path}',
                                  extra: state.tests[index],
                                )
                          : showCupertinoSnackBar(context,
                              "This test is locked - complete lesson block for continue");
                    },
                    id: index,
                    title: state.tests[index].title,
                    trailing: state.tests[index].isOpen
                        ? Icon(
                            CupertinoIcons.forward,
                            size: 30,
                            color: Colors.white,
                          )
                        : Icon(
                            CupertinoIcons.lock_fill,
                            size: 30,
                            color: Colors.white,
                          ),
                    color: state.tests[index].isOpen
                        ? Color(0xFF92BE3F)
                        : Color(0xFFDF3E3E),
                    subtitle: state.tests[index].isOpen
                        ? Row(
                            children: [
                              Text(
                                state.tests[index].isComplete
                                    ? "Done"
                                    : "In progress",
                                style: TextStyle(color: Colors.white),
                              ),
                              Gap(7),
                              Icon(
                                state.tests[index].isComplete
                                    ? CupertinoIcons.check_mark_circled_solid
                                    : CupertinoIcons.check_mark_circled,
                                size: 30,
                                color: Colors.white,
                              ),
                            ],
                          )
                        : null,
                  );
                },
              )
            : Center(child: CupertinoActivityIndicator());
      },
    );
  }
}
