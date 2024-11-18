import 'dart:ui';
import 'package:dynasty_dive/src/core/utils/app_icon.dart';
import 'package:dynasty_dive/src/core/utils/icon_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../routes/route_value.dart';

class BottomBar extends StatefulWidget {

  final void Function(int) onTap;
  const BottomBar(
      {super.key, required this.onTap});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: SizedBox(
          height: 77,
          child: Stack(
            children: [
              SizedBox(
                height: 82,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 37),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildIconButton(
                        index: 0,
                        iconUrl: IconProvider.home.buildImageUrl(),
                        onPressed: () {
                          context.go(RouteValue.home.path);
                          _onItemTapped(0);
                        },
                      ),
                      _buildIconButton(
                        index: 1,
                        iconUrl: IconProvider.lessons.buildImageUrl(),
                        onPressed: () {
                          context.go(RouteValue.sections.path);
                          _onItemTapped(1);
                        },
                      ),
                      _buildIconButton(
                        index: 2,
                        iconUrl: IconProvider.quiz.buildImageUrl(),
                        onPressed: () {
                          context.go(RouteValue.quizess.path);
                          _onItemTapped(2);
                        },
                      ),
                      _buildIconButton(
                        index: 3,
                        iconUrl: IconProvider.tips.buildImageUrl(),
                        onPressed: () {
                          context.go(RouteValue.notions.path);
                          _onItemTapped(3);
                        },
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

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    widget.onTap(index);
  }

  Widget _buildIconButton({
    required int index,
    required String iconUrl,
    required VoidCallback onPressed,
  }) {
    return IconButton(
        onPressed: onPressed,
        icon: AppIcon(
          asset: iconUrl,
          color: index == _currentIndex ? const Color(0xFFDF3E3E) : null,
        ));
  }
}
