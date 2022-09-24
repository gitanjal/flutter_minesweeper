import 'package:flutter/material.dart';
import 'package:minesweeper/cell.dart';
import 'package:minesweeper/models/cell.dart';
import 'package:minesweeper/models/minesweeper.dart';

class MinesweeperBoard extends StatefulWidget {
  MinesweeperBoard(this.minesweeper, {Key? key}) : super(key: key);

  Minesweeper minesweeper;

  @override
  State<MinesweeperBoard> createState() => _MinesweeperBoardState();
}

class _MinesweeperBoardState extends State<MinesweeperBoard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Minesweeper',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: widget.minesweeper.cells.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.minesweeper.colCount),
                  itemBuilder: (BuildContext context, int index) {
                    Cell cell = widget.minesweeper.cells[index];
                    return CellUI(cell, widget.minesweeper.state, () {
                      //The cell has been tapped : attempt to reveal
                      widget.minesweeper.attemptToReveal(cell);

                      setState(() {});
                    },() {
                      widget.minesweeper.addFlag(cell);
                      setState((){});
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildMessageWidget(),
                IconButton(
                    onPressed: () {
                      widget.minesweeper = Minesweeper();
                      setState(() {});
                    },
                    icon: Icon(Icons.refresh))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildMessageWidget() {
    Widget widgetToReturn;
    switch (widget.minesweeper.state) {
      case GameState.won:
        widgetToReturn = Text(
          'Game over,YOU WON',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        );
        break;
      case GameState.lost:
        widgetToReturn = Text(
          'Game over,YOU LOST',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        );
        break;
      default:
        widgetToReturn = Container();
        break;
    }

    return widgetToReturn;
  }
}
