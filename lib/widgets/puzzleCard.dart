import 'package:flutter_puzzle_game/enums/puzzleLevel.dart';
import 'package:flutter_puzzle_game/models/puzzleModel.dart';
import 'package:flutter_puzzle_game/models/screenSize.dart';
import 'package:flutter_puzzle_game/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class PuzzleCard extends StatefulWidget {
  final PuzzleModel puzzleModel;
  final VoidCallback onTap;
  const PuzzleCard({Key? key, required this.puzzleModel, required this.onTap})
      : super(key: key);

  @override
  _PuzzleCardState createState() => _PuzzleCardState();
}

class _PuzzleCardState extends State<PuzzleCard> {
  void waitingImageToComplete() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      if (widget.puzzleModel.completed)
        setState(() {});
      else
        waitingImageToComplete();
    });
  }

  @override
  void initState() {
    super.initState();
    waitingImageToComplete();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          padding: EdgeInsets.all(context.read<ScreenSize>().width * .035),
          width: context.read<ScreenSize>().width * .465,
          decoration: BoxDecoration(
            color: appMainGrey,
            borderRadius: BorderRadius.all(
              Radius.circular(context.read<ScreenSize>().width * .03),
            ),
          ),
          child: widget.puzzleModel.completed
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(
                          context.read<ScreenSize>().width * .015)),
                      child: Container(
                        height: context.read<ScreenSize>().width * .386,
                        width: context.read<ScreenSize>().width * .386,
                        child: Image.file(
                          widget.puzzleModel.imageFile!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      widget.puzzleModel.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Mont",
                          fontSize: context.read<ScreenSize>().width * .035,
                          fontWeight: FontWeight.w700),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: context.read<ScreenSize>().width * .157,
                          height: context.read<ScreenSize>().width * .06,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: appMainBlue,
                            borderRadius: BorderRadius.all(Radius.circular(
                                context.read<ScreenSize>().width * .035)),
                          ),
                          child: Text(
                            "${widget.puzzleModel.puzzleDuration.inMinutes}:${(widget.puzzleModel.puzzleDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Mont",
                                fontSize:
                                    context.read<ScreenSize>().width * .033),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: context.read<ScreenSize>().width * .17,
                          height: context.read<ScreenSize>().width * .06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(
                                context.read<ScreenSize>().width * .04)),
                            border: Border.all(
                              color: widget.puzzleModel.puzzleLevel ==
                                      PuzzleLevel.Hard
                                  ? Colors.orange
                                  : (widget.puzzleModel.puzzleLevel ==
                                          PuzzleLevel.Easy
                                      ? Colors.white
                                      : Colors.blue),
                              width: context.read<ScreenSize>().width * .005,
                            ),
                          ),
                          child: Text(
                            widget.puzzleModel.puzzleLevel
                                .toString()
                                .split(".")[1],
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Mont",
                                fontSize:
                                    context.read<ScreenSize>().width * .03),
                          ),
                        )
                      ],
                    )
                  ],
                )
              : Center(
                  child: SpinKitFadingCircle(
                    color: Colors.white,
                  ),
                )),
    );
  }
}
