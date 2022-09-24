import 'package:flutter/material.dart';
import 'package:minesweeper/models/cell.dart';
import 'package:minesweeper/models/minesweeper.dart';

class CellUI extends StatelessWidget {
  const CellUI(this.cell, this.gameState,this.onTapCell,this.onLongPressCell,  {Key? key})
      : super(key: key);

  final Cell cell;
  final Function onTapCell;
  final Function onLongPressCell;
  final GameState gameState;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(gameState==GameState.started) {
          onTapCell();
        }
      },
      onLongPress: (){
        if(gameState==GameState.started) {
          onLongPressCell();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: gameState == GameState.started
            ? widgetByCellState(cell)
            : OpenCell(cell: cell),
      ),
    );
  }
}

Widget widgetByCellState(Cell cell) {
  Widget widgetToReturn;
  switch (cell.state) {
    case CellState.open:
      widgetToReturn = OpenCell(cell: cell);
      break;
    case CellState.close:
      widgetToReturn = CloseCell(cell: cell);
      break;
    case CellState.flagged:
      widgetToReturn = FlaggedCell(cell: cell);
      break;
  }

  return widgetToReturn;
}

class OpenCell extends StatelessWidget {
  const OpenCell({
    Key? key,
    required this.cell,
  }) : super(key: key);

  final Cell cell;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      color: Colors.grey,
      child: cell.hasMine
          ? Icon(Icons.light_mode)
          : Center(
              child: Text(
                  '${cell.adjacentMineCount == 0 ? '' : cell.adjacentMineCount}')),
    );
  }
}

class CloseCell extends StatelessWidget {
  const CloseCell({
    Key? key,
    required this.cell,
  }) : super(key: key);

  final Cell cell;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      color: Colors.amber,
    );
  }
}

class FlaggedCell extends StatelessWidget {
  const FlaggedCell({
    Key? key,
    required this.cell,
  }) : super(key: key);

  final Cell cell;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50, width: 50, color: Colors.grey, child: Icon(Icons.flag));
  }
}
