import 'package:dynasty_dive/src/feature/quizess/bloc/test_bloc.dart';
import 'package:dynasty_dive/src/feature/quizess/models/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends StatelessWidget {
  final Test test;
  const ResultScreen({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 36, bottom: 80),
      child: Column(
        children: [
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
                  test.title,
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
                  test.dificulty == 0
                      ? "Easy"
                      : test.dificulty == 1
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Gap(16),
                  Material(
                    color: Colors.transparent,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: const Color(0xFFEFEFEF),
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Score',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${test.result?.totalScore ?? 0}',
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(16),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context
                            .read<TestBloc>()
                            .add(ResetTestEvent(test: test, context: context));
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: const Alignment(0.99, -0.16),
                            end: const Alignment(-0.99, 0.16),
                            colors: [
                              Color(0xFFDF3E3E),
                              Color(0xFFDF3E3E).withOpacity(0.5)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 18),
                            child: Text(
                              'RESTART',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: 'Mon',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
