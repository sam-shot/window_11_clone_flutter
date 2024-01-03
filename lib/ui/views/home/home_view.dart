import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:window_11/core/model/taskbar_model.dart';
import 'package:window_11/core/model/window_manager.dart';
import 'package:window_11/core/utils/assets.dart';
import 'package:window_11/ui/style/colors.dart';
import 'package:window_11/ui/style/typography.dart';
import 'package:window_11/ui/views/taskbar/taskbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          AssetData.bgwhite,
                        ),
                        fit: BoxFit.cover),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeIcon(id: "weatherA"),
                      HomeIcon(id: "weatherB"),
                      HomeIcon(id: "weatherC"),
                    ],
                  ),
                ),
              ),
              const Taskbar(),
            ],
          ),
          ...context.watch<WindowManager>().allWindows.map((e) {
            return e.app;
          }),
          if (context.watch<TaskbarModel>().startMenuOpened) const StartMenu()
        ],
      ),
    );
  }
}

class WindowWidget extends StatefulWidget {
  final String id;

  const WindowWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _WindowWidgetState createState() => _WindowWidgetState();
}

class _WindowWidgetState extends State<WindowWidget> {
  Offset position = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onTap: () => context.read<WindowManager>().bringToFront(widget.id),
        child: Container(
          width: 500,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 3),
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            children: [
              GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    position += details.delta;
                  });
                },
                child: SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Image.asset(AssetData.weather),
                          const Gap(10),
                          const Text(
                            "Weather App",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          )
                        ],
                      ),
                      const Expanded(
                        child: SizedBox(
                          height: 30,
                          width: double.infinity,
                          child: Text(""),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            PhosphorIconsRegular.rectangle,
                            size: 20,
                          ),
                          const Gap(10),
                          InkWell(
                            onTap: () {
                              context
                                  .read<WindowManager>()
                                  .removeApp(widget.id);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              padding: const EdgeInsets.all(2),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeIcon extends StatelessWidget {
  final String id;
  const HomeIcon({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: Material(
        elevation: 0,
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          splashColor: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AssetData.weather),
                const SizedBox(height: 6),
                Text(
                  "Weather App",
                  style: AppTextStyle.bold(14),
                ),
              ],
            ),
          ),
        ),
      ),
      childWhenDragging: Container(),
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        child: InkWell(
          onDoubleTap: () {
            context.read<WindowManager>().newWindow(id);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AssetData.weather),
                const SizedBox(height: 6),
                Text(
                  "Weather App",
                  style: AppTextStyle.bold(14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
