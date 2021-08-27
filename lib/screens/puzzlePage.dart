import 'dart:io';

import 'package:axie_scholarship/models/puzzleImage.dart';
import 'package:axie_scholarship/models/puzzleTileModel.dart';
import 'package:axie_scholarship/models/screenSize.dart';
import 'package:axie_scholarship/widgets/puzzleTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  _PuzzlePageState createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  PuzzleImage puzzleImage = PuzzleImage.fromUrl(
      imageLink: "https://i.ibb.co/5T39vkz/insect.jpg",
      imageName: "insect.jpg");
  void rebuildingAfterFileIsLoaded() {
    Future.delayed(Duration(seconds: 1)).then((value) async {
      if (puzzleImage.imageFile != null) {
        for (var i = 0; i < 8; i++) {
          puzzleImage.puzzleTiles.add(PuzzleTileModel(
              tileImage: (await puzzleImage.getCropByIndex(index: i))!,
              correctIndex: i,
              currentIndex: i));
        }
        puzzleImage.puzzleTiles.shuffle();
        for (var i = 0; i < puzzleImage.puzzleTiles.length; i++) {
          puzzleImage.puzzleTiles[i].currentIndex = i;
        }
        setState(() {});
      } else {
        rebuildingAfterFileIsLoaded();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    rebuildingAfterFileIsLoaded();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: puzzleImage.puzzleTiles.length == 8
              ? Column(
                  children: [
                    Container(
                      width: context.read<ScreenSize>().width * .9,
                      height: context.read<ScreenSize>().width * .9,
                      alignment: Alignment.center,
                      color: Colors.amber,
                      child: Stack(
                          children: List.generate(
                              puzzleImage.puzzleTiles.length, (index) {
                        return Provider<PuzzleImage>(
                          create: (_) => puzzleImage,
                          child: PuzzleTile(
                            puzzleTileModel: puzzleImage.puzzleTiles[index],
                            height: context.read<ScreenSize>().width * .3,
                          ),
                        );
                      })),
                    ),
                    Container(
                      child: Image.file(puzzleImage.imageFile!),
                      width: context.read<ScreenSize>().width * .5,
                      height: context.read<ScreenSize>().width * .5,
                    ),
                  ],
                )
              : Container(color: Colors.redAccent),
        )),
      ),
    );
  }
}
