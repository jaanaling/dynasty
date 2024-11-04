import 'dart:ui';
import 'package:dynasty_dive/src/core/utils/icon_provider.dart';
import 'package:dynasty_dive/ui_kit/app_icon/widget/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

class BottomBar extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onTap;
  const BottomBar(
      {super.key, required this.selectedIndex, required this.onTap});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 1;

  // Углы для каждой иконки
  final List<double> _initialAngles = [0, -18, 0];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const RadialGradient(
            colors: [
              Color(0xFFE7357C),
              Color(0xFFFF95CF),
            ],
            center: Alignment.topRight,
            radius: 4.0,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFE7357C),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            SizedBox(
              height: 82,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 37),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // _buildIconButton(
                    //   index: 0,
                    //   iconUrl: IconProvider.calculator.buildImageUrl(),
                    //   initialAngle: _initialAngles[0],
                    //   onPressed: () {
                    //     context.go(RouteValue.calculator.path);
                    //     _onItemTapped(0);
                    //   },
                    // ),
                    // _buildIconButton(
                    //   index: 1,
                    //   iconUrl: IconProvider.cane.buildImageUrl(),
                    //   initialAngle: _initialAngles[1],
                    //   onPressed: () {
                    //     context.go(RouteValue.sweets.path);
                    //     _onItemTapped(1);
                    //   },
                    // ),
                    // _buildIconButton(
                    //   index: 2,
                    //   iconUrl: IconProvider.note.buildImageUrl(),
                    //   initialAngle: _initialAngles[2],
                    //   onPressed: () {
                    //     _onItemTapped(2);
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                //    _buildAnimatedSelection(0),
                //    _buildAnimatedSelection(1),
                //    _buildAnimatedSelection(2),
                  ],
                ),
              ),
            ),
          ],
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
    required double initialAngle,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TweenAnimationBuilder для поворота
          TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: 0,
              end: _currentIndex == index ? 15 : 0,
            ),
            duration: const Duration(milliseconds: 300),
            builder: (context, angle, child) {
              return Transform.rotate(
                angle: (initialAngle + angle) * math.pi / 180,
                child: child,
              );
            },
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0,
                end: _currentIndex == index ? -5 : 0,
              ),
              duration: const Duration(milliseconds: 300),
              builder: (context, offset, child) {
                return Transform.translate(
                  offset: Offset(0, offset),
                  child: AppIcon(
                    asset: iconUrl,
                    height: index == 1 ? 52 : 40,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  
}