import 'package:axie_scholarship/models/puzzleModel.dart';
import 'package:axie_scholarship/models/puzzleTileModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PuzzleTile extends StatefulWidget {
  final double tileMargin;
  final PuzzleTileModel puzzleTileModel;
  final double height;
  final int linearTilesNumber;
  const PuzzleTile({
    Key? key,
    required this.puzzleTileModel,
    required this.height,
    required this.tileMargin,
    required this.linearTilesNumber,
  }) : super(key: key);

  @override
  _PuzzleTileState createState() => _PuzzleTileState();
}

class _PuzzleTileState extends State<PuzzleTile>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    this.widget.puzzleTileModel.animataionController =
        AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.puzzleTileModel.currentIndex;
    int marginUnitHorizontal = index % widget.linearTilesNumber,
        marginUnitVertical = 0;
    for (var i = widget.linearTilesNumber, margin = 0;
        i <= widget.linearTilesNumber * widget.linearTilesNumber;
        i = i + widget.linearTilesNumber, margin++) {
      if (index < i) {
        marginUnitVertical = margin;
        break;
      }
    }
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      left: (widget.puzzleTileModel.currentIndex % widget.linearTilesNumber) *
              widget.height +
          (widget.tileMargin * marginUnitHorizontal),
      top: (widget.puzzleTileModel.currentIndex / widget.linearTilesNumber)
                  .floor() *
              widget.height +
          (widget.tileMargin * marginUnitVertical),
      curve: Curves.decelerate,
      child: InkWell(
        child: GestureDetector(
          onTap: () {
            setState(() {
              context
                  .read<PuzzleModel>()
                  .moveTileByIndex(puzzleTile: widget.puzzleTileModel);
            });
          },
          child: Container(
            height: this.widget.height,
            width: this.widget.height,
            child: Image.file(
              widget.puzzleTileModel.tileImage,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
