import 'package:flutter_puzzle_game/enums/puzzleState.dart';
import 'package:flutter_puzzle_game/models/puzzleStateWrapper.dart';
import 'package:flutter_puzzle_game/models/screenSize.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CircularCountdown extends StatefulWidget {
  final Duration countdownDuration;
  final VoidCallback onFinished;
  const CircularCountdown(
      {Key? key, required this.countdownDuration, required this.onFinished})
      : super(key: key);

  @override
  _CircularCountdownState createState() => _CircularCountdownState();
}

class _CircularCountdownState extends State<CircularCountdown>
    with TickerProviderStateMixin {
  late AnimationController _countdownController;
  @override
  void initState() {
    _countdownController = AnimationController(
      duration: widget.countdownDuration,
      vsync: this,
    );
    _countdownController.addStatusListener((status) {
      if (status == AnimationStatus.completed) widget.onFinished();
    });
    _countdownController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<PuzzleState>();
    if (context.read<PuzzleState>() == PuzzleState.ToBeRestarted) {
      context.read<PuzzleStateWrapper>().play();
      this._countdownController.reset();
      this._countdownController.forward();
    }
    if (context.read<PuzzleState>() == PuzzleState.Pause) {
      this._countdownController.stop();
    }
    return AnimatedBuilder(
        animation: _countdownController,
        builder: (context, child) {
          Duration duration = Duration(
              milliseconds: ((1 - _countdownController.value) *
                      _countdownController.duration!.inMilliseconds)
                  .round());
          String time =
              '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: context.read<ScreenSize>().height * .12,
                height: context.read<ScreenSize>().height * .12,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  value: _countdownController.value,
                  valueColor: AlwaysStoppedAnimation(Color(0xffCCCCCC)),
                  strokeWidth: context.read<ScreenSize>().width * .02,
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontFamily: "Mont",
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: context.read<ScreenSize>().width * .08,
                ),
              ),
            ],
          );
        });
  }
}
