import 'package:dynasty_dive/src/core/dependency_injection.dart';
import 'package:dynasty_dive/src/feature/app/presentation/app_root.dart';
import 'package:dynasty_dive/src/feature/home/bloc/home_bloc.dart';
import 'package:dynasty_dive/src/feature/lesson/bloc/lesson_bloc.dart';
import 'package:dynasty_dive/src/feature/notions/bloc/notion_bloc.dart';
import 'package:dynasty_dive/src/feature/quizess/bloc/test_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjection();

  // await Firebase.initializeApp();

  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LessonBloc()..add(const LoadLessonEvent()),
        ),
        BlocProvider(
          create: (context) => NotionBloc()..add(LoadNotions()),
        ),
        BlocProvider(
          create: (context) => HomeBloc()..add(const HomeLoadedEvent()),
        ),
        BlocProvider(
          create: (context) => TestBloc()..add(LoadTestsEvent()),
        ),
      ],
      child: const AppRoot(),
    ),
  );
}
