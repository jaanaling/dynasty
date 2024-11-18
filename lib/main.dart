import 'dart:async';

import 'package:core_logic/core_logic.dart';
import 'package:dynasty_dive/routes/route_value.dart';
import 'package:dynasty_dive/src/core/dependency_injection.dart';
import 'package:dynasty_dive/src/feature/app/presentation/app_root.dart';
import 'package:dynasty_dive/src/feature/home/bloc/home_bloc.dart';
import 'package:dynasty_dive/src/feature/lesson/bloc/lesson_bloc.dart';
import 'package:dynasty_dive/src/feature/notions/bloc/notion_bloc.dart';
import 'package:dynasty_dive/src/feature/quizess/bloc/test_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_amplitude/core_amplitude.dart';

void main() async {
   runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
     // ... your code here

      FlutterError.onError = (FlutterErrorDetails details) {
         _handleFlutterError(details);
      };
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjection();

  // await Firebase.initializeApp();

  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

   await InitializationUtil.coreInit(
    domain: 'dynastydive.com',
    amplitudeKey: 'd7a8b5fb3fb56b49df4110dc0a0d1d7b',
    appsflyerDevKey: 'PNdQvUj6rGTgD7FbUEAWiS',
    appId: 'com.pocketcraftlls.dynastydive',
    iosAppId: '6738090897',
    initialRoute: RouteValue.home.path,
    facebookAppId: '',
    facebookClientToken: ''
  );

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
  }, (Object error, StackTrace stackTrace) {
      _handleAsyncError(error, stackTrace);
   });
}

void _handleFlutterError(FlutterErrorDetails details) {
   AmplitudeUtil.logFailure(
      details.exception is Exception ? Failure.exception : Failure.error,
      details.exception.toString(),
      details.stack,
   );
}

void _handleAsyncError(Object error, StackTrace stackTrace) {
   AmplitudeUtil.logFailure(
      error is Exception ? Failure.exception : Failure.error,
      error.toString(),
      stackTrace,
   );
}