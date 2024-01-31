import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_11/core/model/taskbar_model.dart';
import 'package:window_11/core/model/window_manager.dart';
import 'package:window_11/core/utils/assets.dart';
import 'package:window_11/ui/views/taskbar/taskbar.dart';
import 'package:window_11/ui/views/widgets/icon_home.dart';
import 'package:window_11/ui/views/widgets/start_menu.dart';

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
          if (context.watch<WindowManager>().allWindows.isNotEmpty)
            context
                .watch<WindowManager>()
                .allWindows
                .firstWhere(
                    (e) => e.id == context.read<WindowManager>().activeWindow)
                .app,
          // if (context.watch<WindowManager>().activeWindow != null)
          //   context.watch<WindowManager>().activeWindow!.app,
          if (context.watch<TaskbarModel>().startMenuOpened) const StartMenu()
        ],
      ),
    );
  }
}
