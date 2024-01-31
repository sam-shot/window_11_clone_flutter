// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:window_11/core/model/taskbar_model.dart';

class StartMenu extends StatefulWidget {
  const StartMenu({Key? key}) : super(key: key);

  @override
  _StartMenuState createState() => _StartMenuState();
}

class _StartMenuState extends State<StartMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200), // Adjust duration as needed
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.ease),
    );

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 60,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {
          context.read<TaskbarModel>().startMenuOpened = false;
          context.read<TaskbarModel>().updateUI();
        },
        child: Container(
          color: Colors.grey.withOpacity(0),
          child: Column(
            children: [
              const Spacer(),
              SlideTransition(
                position: _offsetAnimation,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                    child: Container(
                      width: 450,
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.7),
                      ),
                      child: const Column(
                        children: [
                          Text("f"),
                          // Add other widgets as needed
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(5),
            ],
          ),
        ),
      ),
    );
  }
}