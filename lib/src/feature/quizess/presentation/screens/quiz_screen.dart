import 'package:dynasty_dive/routes/route_value.dart';
import 'package:dynasty_dive/src/feature/quizess/bloc/test_bloc.dart';
import 'package:dynasty_dive/ui_kit/app_tile.dart';
import 'package:dynasty_dive/ui_kit/cupertino_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestBloc, TestState>(
      builder: (context, state) {
        if (state is TestInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TestLoadedState &&  state.currentTest!.currentQuestionIndex < state.currentTest!.questions.length)  {
          final curTest = state.currentTest;

          if (curTest == null) {
            return Container();
          }

          final currentQuestion =
              curTest.questions[curTest.currentQuestionIndex];

          return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Gap(5),
                  Row(
                    children: [
                      CupertinoButton(
                        child: const Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                          size: 36,
                        ),
                        onPressed: () => context.pop(),
                      ),
                      const Gap(5),
                      Expanded(
                        flex: 2,
                        child: Text(
                          curTest.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            height: 0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Gap(5),
                      const SizedBox(
                        height: 53,
                        child: VerticalDivider(
                          width: 2,
                          color: Color(0xFF6D6D6D),
                          thickness: 2,
                        ),
                      ),
                      const Gap(15),
                      Expanded(
                        child: Text(
                          curTest.dificulty == 1
                              ? "Easy"
                              : curTest.dificulty == 2
                                  ? "Medium"
                                  : "Hard",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            height: 0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 16),
                    child: Text(
                      currentQuestion.question,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) => const Gap(14),
                    shrinkWrap: true,
                    itemCount: currentQuestion.answers.length,
                    padding:
                        const EdgeInsets.only(bottom: 140, left: 17, right: 17),
                    itemBuilder: (context, index) {
                      return AppTile(
                        id: index,
                        title: currentQuestion.answers[index].answerText,
                        color: const Color(0xFF989898),
                        onTap: () {
                          context.read<TestBloc>().add(
                                SubmitAnswerEvent(
                                  context: context,
                                  currentQuestionIndex:
                                      curTest.currentQuestionIndex,
                                  score: (currentQuestion.answers[index].score *
                                      curTest.dificulty),
                                  testId: curTest.id,
                                  curTest: curTest
                                ),
                              );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }

        return const Center(child: Text('Error loading tests'));
      },
    );
  }
}
