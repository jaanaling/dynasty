import 'package:dynasty_dive/src/feature/home/bloc/home_bloc.dart';
import 'package:dynasty_dive/src/feature/lesson/bloc/lesson_bloc.dart';
import 'package:dynasty_dive/src/feature/notions/bloc/notion_bloc.dart';
import 'package:dynasty_dive/src/feature/quizess/bloc/test_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../../routes/go_router_config.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LessonBloc()..add(LoadLessonEvent()),
        ),
        BlocProvider(
          create: (context) => NotionBloc()..add(LoadNotions()),
        ),
        BlocProvider(
          create: (context) => HomeBloc()..add(HomeLoadedEvent()),
        ),
        BlocProvider(
          create: (context) => TestBloc()..add(LoadTestsEvent()),
        ),
      ],
      child: CupertinoApp.router(
        theme: const CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFFDF3E3E),
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(
              fontFamily: 'Stetica',
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: buildGoRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
