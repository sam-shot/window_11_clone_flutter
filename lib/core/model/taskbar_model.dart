import 'package:flutter/material.dart';

class TaskbarModel extends ChangeNotifier{
  bool startMenuOpened = false;

  void updateUI(){
    notifyListeners();
  }
}