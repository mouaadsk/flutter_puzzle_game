import 'dart:math';

import 'package:axie_scholarship/models/puzzleModel.dart';
import 'package:axie_scholarship/models/screenSize.dart';
import 'package:axie_scholarship/shared/colors.dart';
import 'package:axie_scholarship/widgets/circularCountdown.dart';
import 'package:axie_scholarship/widgets/customPuzzleDialog.dart';
import 'package:axie_scholarship/widgets/puzzleTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PuzzlePage extends StatefulWidget {
  final PuzzleModel puzzleModel;
  PuzzlePage({Key? key, required this.puzzleModel}) : super(key: key);

  @override
  _PuzzlePageState createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  void rebuildingAfterFileIsLoaded() {
    Future.delayed(Duration(seconds: 2)).then((value) async {
      print("called rebuildingAfterIsLoaded");
      if (widget.puzzleModel.completed)
        setState(() {});
      else
        rebuildingAfterFileIsLoaded();
    });
  }

  @override
  void initState() {
    super.initState();
    rebuildingAfterFileIsLoaded();
  }

  @override
  Widget build(BuildContext context) {
    print("the value of completed : ${widget.puzzleModel.completed}");
    return Scaffold(
      backgroundColor: bgBlack,
      body: SafeArea(
        child: widget.puzzleModel.completed
            ? Stack(
                alignment: Alignment.center,
                children: [
                  //! the back button
                  Positioned(
                    left: context.read<ScreenSize>().width * .03,
                    top: context.read<ScreenSize>().width * .03,
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        "assets/vectors/leftArrow.svg",
                        color: Colors.white,
                        height: context.read<ScreenSize>().width * .05,
                        width: context.read<ScreenSize>().width * .05,
                      ),
                      constraints: BoxConstraints(
                          maxHeight: context.read<ScreenSize>().width * .12,
                          maxWidth: context.read<ScreenSize>().width * .12,
                          minHeight: context.read<ScreenSize>().width * .12,
                          minWidth: context.read<ScreenSize>().width * .12),
                      fillColor: appMainGrey,
                      shape: CircleBorder(),
                    ),
                  ),
                  //! the top wide card (image and the countdown circle)
                  Positioned(
                    top: context.read<ScreenSize>().height * .1,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(
                              context.read<ScreenSize>().width * .025)),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                context.read<ScreenSize>().width * .1,
                                0.0,
                                context.read<ScreenSize>().width * .03,
                                0.0),
                            height: context.read<ScreenSize>().height * .22,
                            width: context.read<ScreenSize>().width * .9,
                            decoration: BoxDecoration(color: appMainGrey),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircularCountdown(
                                  countdownDuration:
                                      widget.puzzleModel.puzzleDuration,
                                  onFinished: () {
                                    ScreenSize screenSize =
                                        context.read<ScreenSize>();
                                    print(screenSize.width);
                                    showDialog(
                                        context: context,
                                        builder: (context) => MultiProvider(
                                              providers: [
                                                Provider<ScreenSize>(
                                                  create: (_) => screenSize,
                                                ),
                                              ],
                                              child: PuzzleCustomDialog(
                                                textBody:
                                                    "You didn't solve the puzzle.\n Do you want to play again ?",
                                                title: "Game Over",
                                                actions: [
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                appMainGrey,
                                                            fixedSize: Size(
                                                              screenSize.width *
                                                                  .4,
                                                              screenSize.width *
                                                                  .1,
                                                            ),
                                                            textStyle:
                                                                TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Mont",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            )),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("No"),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            fixedSize: Size(
                                                              screenSize.width *
                                                                  .4,
                                                              screenSize.width *
                                                                  .1,
                                                            ),
                                                            textStyle:
                                                                TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Mont",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            )),
                                                    onPressed: () {},
                                                    child: Text("Yes"),
                                                  ),
                                                ],
                                              ),
                                            ));
                                  },
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          context.read<ScreenSize>().width *
                                              .02)),
                                  child: Image.file(
                                    widget.puzzleModel.imageFile!,
                                    height:
                                        context.read<ScreenSize>().height * .18,
                                    width:
                                        context.read<ScreenSize>().height * .18,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: context.read<ScreenSize>().height * .1),
                        Container(
                          color: appLightGrey,
                          width: context.read<ScreenSize>().width,
                          height: context.read<ScreenSize>().height * .6,
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(
                                context.read<ScreenSize>().width * .03)),
                            child: Container(
                              width: context.read<ScreenSize>().width * .92,
                              height: context.read<ScreenSize>().width * .92,
                              child: Stack(
                                children: List.generate(
                                    widget.puzzleModel.puzzleTiles.length,
                                    (index) {
                                  return Provider<PuzzleModel>(
                                    create: (_) => widget.puzzleModel,
                                    child: PuzzleTile(
                                      puzzleTileModel:
                                          widget.puzzleModel.puzzleTiles[index],
                                      height: (context
                                                  .read<ScreenSize>()
                                                  .width *
                                              .9) /
                                          sqrt(
                                              widget.puzzleModel.numberOfTiles),
                                      linearTilesNumber:
                                          sqrt(widget.puzzleModel.numberOfTiles)
                                              .floor(),
                                      tileMargin:
                                          context.read<ScreenSize>().width *
                                              .02 /
                                              (sqrt(widget.puzzleModel
                                                          .numberOfTiles)
                                                      .floor() -
                                                  1),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container(
                color: appMainGrey,
              ),
      ),
    );
  }
}
