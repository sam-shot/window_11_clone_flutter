import 'package:flutter/material.dart';
import 'package:window_11/core/model/window_manager.dart';

class TaskbarModel extends ChangeNotifier{
  bool startMenuOpened = false;

  List<String> allTaskarItems = [];

  void updateUI(){
    notifyListeners();
  }

  addToTaskbar(String id){
    allTaskarItems.add(id);
    notifyListeners();
  }
  removeFromTaskbar(String id){
    allTaskarItems.remove(id);
    notifyListeners();
  }
}