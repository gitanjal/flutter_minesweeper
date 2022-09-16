import 'package:flutter/material.dart';
import 'package:minesweeper/models/cell.dart';
import 'package:minesweeper/models/mineweeper.dart';

class MinesweeperBoard extends StatefulWidget {
  const MinesweeperBoard(this.minesweeper, {Key? key}) : super(key: key);
  final Minesweeper minesweeper;

  @override
  State<MinesweeperBoard> createState() => _MinesweeperBoardState();
}

class _MinesweeperBoardState extends State<MinesweeperBoard> {
  @override
  Widget build(BuildContext context) {
    /*todo 1 Step 1: Create a function to create the board widget/or create a board widget*/
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          itemCount: 100,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
          itemBuilder: (context, index) {
            Cell thisCell = widget.minesweeper.cells[index];
            return GestureDetector(
              onTap: () {
                widget.minesweeper.reveal(thisCell);
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: thisCell.revealed
                    ? Container(
                        height: 20,
                        width: 20,
                        color: Colors.red,
                        child: thisCell.hasMine
                            ? Icon(Icons.bolt)
                            : Text(
                                '${thisCell.adjacentMineCount == 0 ? '' : thisCell.adjacentMineCount}'))
                    : Container(
                        height: 20,
                        width: 20,
                        color: Colors.black12,
                        child: thisCell.hasMine
                            ? Icon(Icons.bolt)
                            : Text(
                                '${thisCell.index.toString()/*+''+thisCell.position.y.toString()*//*thisCell.adjacentMineCount == 0 ? '' : thisCell.adjacentMineCount*/}'),
                      ),
              ),
            );
          }),
    );
  }
}
