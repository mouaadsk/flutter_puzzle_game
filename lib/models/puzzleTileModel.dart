import 'dart:io';
import 'package:flutter/material.dart';

class PuzzleTileModel {
  final int correctIndex;
  int currentIndex;
  final File tileImage;
  AnimationController? animataionController;
  PuzzleTileModel(
      {required this.tileImage,
      required this.correctIndex,
      required this.currentIndex});

  bool isRight() {
    return this.currentIndex == this.correctIndex;
  }
}
