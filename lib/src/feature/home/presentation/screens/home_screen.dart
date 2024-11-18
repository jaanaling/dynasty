import 'package:dynasty_dive/routes/route_value.dart';
import 'package:dynasty_dive/src/core/utils/app_icon.dart';
import 'package:dynasty_dive/src/core/utils/icon_provider.dart';
import 'package:dynasty_dive/src/feature/home/presentation/screens/facts_screen.dart';
import 'package:dynasty_dive/src/feature/notions/bloc/notion_bloc.dart';
import 'package:dynasty_dive/src/feature/notions/models/notion.dart';
import 'package:dynasty_dive/ui_kit/lesson_tile/lesson_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadedState) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dynasty Dive',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      height: 0,
                    ),
                  ),
                  Gap(23),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(21),
                            child: AppIcon(
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                              asset: state.daily.image,
                            ),
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => showLessonDialog(
                            context,
                            state.daily.title,
                            state.daily.content,
                            null,
                            null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 23),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Gap(6),
                                Text(
                                  'Fact of the day',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: 'Stetica',
                                    height: 0,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black
                                            .withOpacity(0.5), // Цвет тени
                                        offset:
                                            Offset(2.0, 2.0), // Смещение тени
                                        blurRadius: 4.0, // Размытие тени
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(8),
                                SizedBox(
                                  height: 80,
                                  child: Text(
                                    state.daily.title,
                                    textAlign: TextAlign.center,
                                    maxLines:
                                        2, // Устанавливает максимальное количество строк
                                    overflow: TextOverflow
                                        .ellipsis, // Указывает, как обрабатывать переполнение
                                    softWrap: true, // Разрешает перенос слов
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Stetica',
                                      shadows: [
                                        Shadow(
                                          color: Colors.black
                                              .withOpacity(0.5), // Цвет тени
                                          offset:
                                              Offset(2.0, 2.0), // Смещение тени
                                          blurRadius: 4.0, // Размытие тени
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      children: [
                        buildLesson(
                          iconUrl: IconProvider.dynasties.buildImageUrl(),
                          color: Color(0xFF93D650),
                          onPressed: () {
                            context.push(
                              "${RouteValue.home.path}/${RouteValue.facts.path}",
                              extra: 'Dates',
                            );
                          },
                          title: 'Dates',
                          context: context,
                        ),
                        buildLesson(
                          iconUrl: IconProvider.culture.buildImageUrl(),
                          color: Color(0xFFEE9E4F),
                          onPressed: () {
                            context.push(
                              "${RouteValue.home.path}/${RouteValue.facts.path}",
                              extra: 'Events',
                            );
                          },
                          title: 'Events',
                          context: context,
                        ),
                        buildLesson(
                          iconUrl:
                              IconProvider.historicalFigure.buildImageUrl(),
                          color: Color(0xFFB550D6),
                          onPressed: () {
                            context.push(
                              "${RouteValue.home.path}/${RouteValue.facts.path}",
                              extra: 'Historical\nfigures',
                            );
                          },
                          title: 'Historical\nfigures',
                          context: context,
                        ),
                        buildLesson(
                          iconUrl: IconProvider.places.buildImageUrl(),
                          color: Color(0xFF508FD6),
                          onPressed: () {
                            context.push(
                              "${RouteValue.home.path}/${RouteValue.facts.path}",
                              extra: 'Places',
                            );
                          },
                          title: 'Places',
                          context: context,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CupertinoActivityIndicator(
              color: Color(0xFFDF3E3E),
            ),
          );
        }
      },
    );
  }

  Widget buildLesson({
    required String iconUrl,
    required Color color,
    required VoidCallback onPressed,
    required String title,
    required BuildContext context,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(21),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Positioned.fill(
                child: AppIcon(
                  asset: iconUrl,
                  color: color,
                  blendMode: BlendMode.color,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  title, softWrap: true, // Разрешает перенос слов
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Stetica',
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5), // Цвет тени
                        offset: Offset(2.0, 2.0), // Смещение тени
                        blurRadius: 4.0, // Размытие тени
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
