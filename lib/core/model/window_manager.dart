import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:window_11/core/utils/util_functions.dart';
import 'package:window_11/ui/views/home/home_view.dart';

class WindowManager extends ChangeNotifier {
  List<WindowModel> allWindows = [];

  void newWindow(String id) {
    if (allWindows.any((e) => e.id == id)) {
      bringToFront(id);
    } else {
      allWindows.add(WindowModel(app: WindowWidget(id: id), id: id));
      notifyListeners();
    }
  }

  void removeApp(String id) {
    final currentWindow = allWindows.firstWhere((e) => e.id == id);
    allWindows.remove(currentWindow);
    notifyListeners();
  }

  void bringToFront(String id) {
    allWindows.sort((a, b) {
      if (a.id == id) {
        return -1; // 'a' comes before 'b'
      } else if (b.id == id) {
        return 1; // 'b' comes before 'a'
      }
      return 0; // no change in order
    });
    notifyListeners();
  }
}

class WindowModel {
  final Widget app;
  final String id;

  WindowModel({required this.app, required this.id});
}
