import 'package:axie_scholarship/models/puzzleImage.dart';
import 'package:axie_scholarship/models/puzzleTileModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PuzzleTile extends StatefulWidget {
  final PuzzleTileModel puzzleTileModel;
  final double height;
  const PuzzleTile(
      {Key? key, required this.puzzleTileModel, required this.height})
      : super(key: key);

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
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      left: (widget.puzzleTileModel.currentIndex % 3) * widget.height,
      top: (widget.puzzleTileModel.currentIndex / 3).floor() * widget.height,
      curve: Curves.elasticIn,
      child: InkWell(
        child: GestureDetector(
          onTap: () {
            setState(() {
              context
                  .read<PuzzleImage>()
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
