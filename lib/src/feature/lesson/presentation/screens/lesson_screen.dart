import 'package:dynasty_dive/routes/route_value.dart';
import 'package:dynasty_dive/src/feature/home/presentation/screens/facts_screen.dart';
import 'package:dynasty_dive/src/feature/lesson/bloc/lesson_bloc.dart';
import 'package:dynasty_dive/src/feature/lesson/models/date.dart';
import 'package:dynasty_dive/src/feature/lesson/models/figure.dart';
import 'package:dynasty_dive/src/feature/lesson/models/lesson.dart';
import 'package:dynasty_dive/src/feature/lesson/models/lesson_bloc.dart';
import 'package:dynasty_dive/src/feature/lesson/models/place.dart';
import 'package:dynasty_dive/src/feature/notions/bloc/notion_bloc.dart';
import 'package:dynasty_dive/src/feature/notions/models/notion.dart';
import 'package:dynasty_dive/src/feature/quizess/bloc/test_bloc.dart';
import 'package:dynasty_dive/ui_kit/app_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class LessonScreen extends StatefulWidget {
  final LessonBlock lessons;
  final String id;

  const LessonScreen({super.key, required this.lessons, required this.id});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late Lesson lesson;
  late bool complete;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lesson =
        widget.lessons.lessons.firstWhere((element) => element.id == widget.id);
    complete = lesson.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonBloc, LessonState>(
      builder: (context, state) {
        return state is LessonLoadedState
            ? ColoredBox(
                color: const Color(0xFF8E2E2E),
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 46, 24, 120),
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
                            const SizedBox(
                              height: 53,
                              child: VerticalDivider(
                                width: 2,
                                color: Color.fromARGB(37, 0, 0, 0),
                                thickness: 2,
                              ),
                            ),
                            const Gap(15),
                            Expanded(
                              child: Text(
                                lesson.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  height: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            CupertinoButton(
                                child: Icon(
                                  complete
                                      ? CupertinoIcons.check_mark_circled_solid
                                      : CupertinoIcons.check_mark_circled,
                                  color: Colors.white,
                                  size: 36,
                                ),
                                onPressed: complete? null: () =>  setState(() {
                                      complete = !complete;
                                      context
                                          .read<LessonBloc>()
                                          .add(CompliteLessonEvent(
                                            lessonBlock: widget.lessons,
                                            lessonId: widget.id,
                                            tests: (context
                                                    .read<TestBloc>()
                                                    .state as TestLoadedState)
                                                .tests, context: context
                                          ));
                                    }))
                          ],
                        ),
                        const Gap(23),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: lesson.topics?.length ?? 0,
                          separatorBuilder: (_, __) => const Gap(2),
                          itemBuilder: (context, index) => Text(
                            '•  ${lesson.topics![index]}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              height: 0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Gap(33),
                        const Divider(
                          height: 2,
                          color: Color.fromARGB(37, 0, 0, 0),
                          thickness: 2,
                        ),
                        const Gap(33),
                        Text(
                          lesson.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            height: 0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(33),
                        const Divider(
                          height: 2,
                          color: Color.fromARGB(37, 0, 0, 0),
                          thickness: 2,
                        ),
                        const Gap(33),
                        HighlightedText(
                          content: lesson.content,
                          highlightedTexts: lesson.highlightedTexts ?? [],
                          state: state,
                        ),
                        const Gap(33),
                        const Divider(
                          height: 2,
                          color: Color.fromARGB(37, 0, 0, 0),
                          thickness: 2,
                        ),
                        const Gap(33),
                        if (lesson.relatedDates != null &&
                            lesson.relatedDates!.length > 0 &&
                            state.date.any(
                                (f) => lesson.relatedDates!.contains(f.id)))
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Related Dates:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                height: 0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        else
                          Container(),
                        if (lesson.relatedDates != null &&
                            lesson.relatedDates!.length > 0 &&
                            state.date.any(
                                (f) => lesson.relatedDates!.contains(f.id)))
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(left: 24, top: 12),
                            itemCount: lesson.relatedDates?.length ?? 0,
                            separatorBuilder: (_, __) => const Gap(2),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => showLessonDialog(
                                context,
                                state.date
                                    .firstWhere(
                                      (test) =>
                                          test.id ==
                                          lesson.relatedDates![index],
                                    )
                                    .date!,
                                state.date
                                        .firstWhere(
                                          (test) =>
                                              test.id ==
                                              lesson.relatedDates![index],
                                        )
                                        .description ??
                                    '',
                                null,
                                null,
                              ),
                              child: Text(
                                '•  ${state.date.firstWhere(
                                      (test) =>
                                          test.id ==
                                          lesson.relatedDates![index],
                                    ).date ?? ''}',
                                style: const TextStyle(
                                  color: CupertinoColors.activeBlue,
                                  fontSize: 19,
                                  height: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        else
                          Container(),
                        const Gap(33),
                        if (lesson.relatedPeople != null &&
                            lesson.relatedPeople!.length > 0 &&
                            state.figure.any(
                                (f) => lesson.relatedPeople!.contains(f.id)))
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Related People:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                height: 0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        else
                          Container(),
                        if (lesson.relatedPeople != null &&
                            lesson.relatedPeople!.length > 0 &&
                            state.figure.any(
                                (f) => lesson.relatedPeople!.contains(f.id)))
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(left: 24, top: 12),
                            itemCount: lesson.relatedPeople?.length ?? 0,
                            separatorBuilder: (_, __) => const Gap(2),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => showLessonDialog(
                                context,
                                state.figure
                                    .firstWhere(
                                      (test) =>
                                          test.id ==
                                          lesson.relatedPeople![index],
                                    )
                                    .name,
                                state.figure
                                        .firstWhere(
                                          (test) =>
                                              test.id ==
                                              lesson.relatedPeople![index],
                                        )
                                        .description ??
                                    '',
                                null,
                                null,
                              ),
                              child: Text(
                                '•  ${state.figure.firstWhere(
                                      (test) =>
                                          test.id ==
                                          lesson.relatedPeople![index],
                                    ).name}',
                                style: const TextStyle(
                                  color: CupertinoColors.activeBlue,
                                  fontSize: 19,
                                  height: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        else
                          Container(),
                        const Gap(33),
                        if (lesson.relatedPlaces != null &&
                            lesson.relatedPlaces!.isNotEmpty &&
                            state.place.any(
                                (f) => lesson.relatedPlaces!.contains(f.id)))
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Related Places:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                height: 0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          )
                        else
                          Container(),
                        if (lesson.relatedPlaces != null &&
                            lesson.relatedPlaces!.length > 0 &&
                            state.place.any(
                                (f) => lesson.relatedPlaces!.contains(f.id)))
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(left: 24, top: 12),
                            itemCount: lesson.relatedPlaces?.length ?? 0,
                            separatorBuilder: (_, __) => const Gap(2),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => showLessonDialog(
                                  context,
                                  state.place
                                      .firstWhere(
                                        (test) =>
                                            test.id ==
                                            lesson.relatedPlaces![index],
                                      )
                                      .name,
                                  state.place
                                      .firstWhere(
                                        (test) =>
                                            test.id ==
                                            lesson.relatedPlaces![index],
                                      )
                                      .description,
                                  null,
                                  LatLng(
                                      double.parse(state.place
                                          .firstWhere(
                                            (test) =>
                                                test.id ==
                                                lesson.relatedPlaces![index],
                                          )
                                          .mapLocation!
                                          .split(",")[0]),
                                      double.parse(state.place
                                          .firstWhere(
                                            (test) =>
                                                test.id ==
                                                lesson.relatedPlaces![index],
                                          )
                                          .mapLocation!
                                          .split(",")[1]))),
                              child: Text(
                                '•  ${state.place.firstWhere(
                                      (test) =>
                                          test.id ==
                                          lesson.relatedPlaces![index],
                                    ).name}',
                                style: const TextStyle(
                                  color: CupertinoColors.activeBlue,
                                  fontSize: 19,
                                  height: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        else
                          Container(),
                        const Gap(33),
                      ],
                    ),
                  ),
                ),
              )
            : Container();
      },
    );
  }
}

class HighlightedText extends StatelessWidget {
  final String content;
  final List<String> highlightedTexts;
  final LessonLoadedState state;

  HighlightedText({
    required this.content,
    required this.highlightedTexts,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> spans = _buildTextSpans(context, content, highlightedTexts);
    return RichText(
      text: TextSpan(
          children: spans, style: const TextStyle(color: Colors.black)),
    );
  }

  List<TextSpan> _buildTextSpans(
    BuildContext context,
    String text,
    List<String> highlights,
  ) {
    List<TextSpan> spans = [];
    int start = 0;

    for (final word in highlights) {
      int index = text.indexOf(word, start);

      if (index >= start) {
        // Добавляем обычный текст до выделенного слова
        if (index > start) {
          spans.add(
            TextSpan(
              text: text.substring(start, index),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                height: 0,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        // Добавляем выделенное слово с GestureRecognizer
        spans.add(
          TextSpan(
            text: word,
            style: const TextStyle(
              fontSize: 20,
              height: 0,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.activeBlue,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                String? description;
                String? image;
                LatLng? mapLocation;
                if (state.place.indexWhere((element) => element.name == word) !=
                    -1) {
                  description = state.place
                      .firstWhere(
                        (element) => element.name == word,
                      )
                      .description;
                  mapLocation = LatLng(
                      double.parse(state.place
                          .firstWhere(
                            (test) => test.name == highlightedTexts[index],
                          )
                          .mapLocation!
                          .split(",")[0]),
                      double.parse(state.place
                          .firstWhere(
                            (test) => test.name == highlightedTexts[index],
                          )
                          .mapLocation!
                          .split(",")[1]));
                }
                if (state.figure
                        .indexWhere((element) => element.name == word) !=
                    -1) {
                  description = state.figure
                      .firstWhere(
                        (element) => element.name == word,
                      )
                      .description;
                  image = state.figure
                      .firstWhere(
                        (element) => element.name == word,
                      )
                      .image;
                }
                if (state.date.indexWhere((element) => element.date == word) !=
                    -1) {
                  description = state.date
                      .firstWhere(
                        (element) => element.date == word,
                      )
                      .description;
                }
                showLessonDialog(
                  context,
                  word,
                  description ?? '',
                  image,
                  mapLocation,
                );
              },
          ),
        );

        start = index + word.length;
      }
    }

    // Добавляем оставшийся текст
    if (start < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(start),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            height: 0,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    return spans;
  }
}
