import 'package:dynasty_dive/src/feature/home/presentation/screens/facts_screen.dart';
import 'package:dynasty_dive/src/feature/home/presentation/screens/home_screen.dart';
import 'package:dynasty_dive/src/feature/lesson/models/lesson_bloc.dart';
import 'package:dynasty_dive/src/feature/notions/presentation/screens/notions_screen.dart';
import 'package:dynasty_dive/src/feature/quizess/models/test.dart';
import 'package:dynasty_dive/src/feature/quizess/presentation/screens/quiz_screen.dart';
import 'package:dynasty_dive/src/feature/quizess/presentation/screens/quizess_screen.dart';
import 'package:dynasty_dive/src/feature/quizess/presentation/screens/result_screen.dart';
import 'package:dynasty_dive/src/feature/lesson/presentation/screens/lesson_screen.dart';
import 'package:dynasty_dive/src/feature/lesson/presentation/screens/lessons_screen.dart';
import 'package:dynasty_dive/src/feature/lesson/presentation/screens/sections_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../src/feature/splash/presentation/screens/splash_screen.dart';
import 'root_navigation_screen.dart';
import 'route_value.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _quizNavigatorKey = GlobalKey<NavigatorState>();
final _sectionsNavigatorKey = GlobalKey<NavigatorState>();
final _notionsNavigatorKey = GlobalKey<NavigatorState>();

GoRouter buildGoRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteValue.splash.path,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) {
        return NoTransitionPage(
          child: RootNavigationScreen(
            navigationShell: navigationShell,
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: RouteValue.home.path,
              builder: (context, state) => Container(
                color: Color(0xFF353535),
                child: HomeScreen(key: UniqueKey()),
              ),
              routes: <RouteBase>[
                GoRoute(
                  path: RouteValue.facts.path,
                  builder: (context, state) => Container(
                    color: Color(0xFF353535),
                    child: FactsScreen(
                        key: UniqueKey(), type: state.extra as String),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _sectionsNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
                path: RouteValue.sections.path,
                builder: (context, state) => Container(
                      color: Color(0xFF353535),
                      child: SectionsScreen(key: UniqueKey()),
                    ),
                routes: [
                  GoRoute(
                      path: RouteValue.lessons.path,
                      builder: (context, state) {
                        final lessons = state.extra as LessonBlock;
                        return Container(
                          color: Color(0xFF353535),
                          child:
                              LessonsScreen(key: UniqueKey(), lessons: lessons),
                        );
                      },
                      routes: [
                        GoRoute(
                            path: RouteValue.lesson.path,
                            builder: (context, state) {
                              final extra = state.extra as Map<String, dynamic>;

                              final lessonId = extra['lessonId'] as String;
                              final lessonBlock =
                                  extra['lessonBlock'] as LessonBlock;

                              return Container(
                                color: Color(0xFF353535),
                                child: LessonScreen(
                                    key: UniqueKey(),
                                    lessons: lessonBlock,
                                    id: lessonId),
                              );
                            }),
                      ]),
                ]),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _quizNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
                path: RouteValue.quizess.path,
                builder: (context, state) => Container(
                      color: Color(0xFF353535),
                      child: QuizessScreen(key: UniqueKey()),
                    ),
                routes: [
                  GoRoute(
                    path: RouteValue.quiz.path,
                    builder: (context, state) => Container(
                      color: Color(0xFF353535),
                      child: QuizScreen(key: UniqueKey()),
                    ),
                  ),
                  GoRoute(
                    path: RouteValue.quizResult.path,
                    builder: (context, state) => Container(
                      color: Color(0xFF353535),
                      child: ResultScreen(
                          key: UniqueKey(), test: state.extra as Test),
                    ),
                  ),
                ]),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _notionsNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: RouteValue.notions.path,
              builder: (context, state) => Container(
                color: Color(0xFF353535),
                child: NotionsScreen(key: UniqueKey()),
              ),
            ),
          ],
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: CupertinoPageScaffold(
            child: child,
          ),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: RouteValue.splash.path,
          builder: (BuildContext context, GoRouterState state) {
            return SplashScreen(key: UniqueKey());
          },
        ),
      ],
    ),
  ],
);
