import 'dart:async';

import 'package:axie_scholarship/enums/puzzleState.dart';

class PuzzleStateWrapper {
  StreamController<PuzzleState> _streamController =
      StreamController<PuzzleState>.broadcast();

  Stream<PuzzleState> get stream => _streamController.stream;

  bool restartPuzzle() {
    _streamController.add(PuzzleState.ToBeRestarted);
    return true;
  }

  bool play() {
    _streamController.add(PuzzleState.Playing);
    return true;
  }

  bool pause() {
    _streamController.add(PuzzleState.Pause);
    return true;
  }
}
