import 'package:dynasty_dive/routes/route_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/icon_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _dotsAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _dotsAnimation = IntTween(begin: 0, end: 3).animate(_controller);
    startLoading(context);
  }

  Future<void> startLoading(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    // final adId = await AdvertisingId.id(true);
    // FirebaseMessaging instance = FirebaseMessaging.instance;
    // final settings =
    //     await instance.requestPermission(alert: true, badge: true, sound: true);
    // if (settings.authorizationStatus != AuthorizationStatus.authorized) {
    //   SharedPreferences.getInstance()
    //       .then((prefs) => prefs.setBool('notificationsEnabled', false));
    // }

    context.go(RouteValue.home.path);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.white,
                Color(0xFFF570AF),
              ],
            ),
          ),
          child: SizedBox.expand(),
        ),
        Positioned.fill(
          child: Image.asset(
            'assets/images/splash.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: height * 0.295,
          child: Column(
            children: [
              Image.asset(
                IconProvider.logo.buildImageUrl(),
                fit: BoxFit.fitWidth,
                width: width * 0.64,
              ),
              const Text(
                'Big Bass Diary',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 37,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      
      ],
    );
  }
}
