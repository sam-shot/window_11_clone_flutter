import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_11/core/model/taskbar_model.dart';
import 'package:window_11/main.dart';
import 'package:window_11/ui/views/widgets/window.dart';

class WindowManager extends ChangeNotifier {
  List<WindowModel> allWindows = [];
  String? activeWindow;

  void newWindow(String id, BuildContext ctx) {
    if (allWindows.any((e) => e.id == id)) {
      bringToFront(id);
    } else {
      allWindows.add(WindowModel(app: WindowWidget(id: id), id: id));
      activeWindow = id;
      navigatorKey!.currentContext!.read<TaskbarModel>().addToTaskbar(id);
      notifyListeners();
    }
  }

  void removeApp(String id) {
    final currentWindow = allWindows.firstWhere((e) => e.id == id);
    allWindows.remove(currentWindow);
    if (allWindows.isNotEmpty) {
      activeWindow = allWindows.last.id;
    }
    navigatorKey!.currentContext!.read<TaskbarModel>().removeFromTaskbar(id);
    notifyListeners();
  }

  void bringToFront(String id) {
    activeWindow = allWindows.firstWhere((e) => e.id == id).id;
    notifyListeners();
  }

  Color generateColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }
}

class WindowModel {
  final Widget app;
  final String id;

  WindowModel({required this.app, required this.id});
}
