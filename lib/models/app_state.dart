import 'package:flutter/cupertino.dart';

// This means AppState cannot be modified partially modified, so every time we want to change state, we must rebuild AppState 
@immutable

class AppState {
  final dynamic user;

  AppState({@required this.user});

  factory AppState.initial() {
    return AppState(user: null);
  }
}