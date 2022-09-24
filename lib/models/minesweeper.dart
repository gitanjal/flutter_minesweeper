import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:minesweeper/models/cell.dart';
import 'package:minesweeper/models/position.dart';

enum GameState { started, won, lost }

class Minesweeper {
  late int count;
  int mineCount;
  int rowCount;
  int colCount;
  int openCellCount = 0;
  late List<Cell> cells;
  late List<Position> minePositions;

  //Game state : started,won,lost
  GameState state = GameState.started;

  Minesweeper({this.mineCount = 10, this.rowCount = 10, this.colCount = 10}) {
    count = rowCount * colCount;

    //Create the mine position
    minePositions = createMinePositions();
    //Create the cells
    cells = createCells();
  }

  List<Position> createMinePositions() {
    List<Position> mineLocations = [];
    for (int i = 0; i < mineCount; i++) {
      //Get two random number
      int x = Random().nextInt(rowCount);
      int y = Random().nextInt(colCount);
      Position position = Position(x, y);

      //Create another if it already exists
      while (mineLocations.contains(position)) {
        x = Random().nextInt(rowCount);
        y = Random().nextInt(colCount);
        position.x = x;
        position.y = y;
      }
      //Add this position to the list
      mineLocations.add(position);
    }
    return mineLocations;
  }

  List<Cell> createCells() {
    List<Cell> cells = [];

    int rowNumber = 0;
    int colNumber = 0;
    for (int i = 0; i < count; i++) {
      //Create a Cell
      //Get the position
      rowNumber = (i / rowCount)
          .toInt(); //e.g. 5/10.toInt()=0 15/10.toInt()=1 1.5.toInt()=1

      /*todo 1: +++++++Find the colNumber++++++++*/

      Position position = Position(rowNumber, colNumber);
      Cell cell = Cell(position);
      //hasMine
      if (minePositions.contains(position)) {
        cell.hasMine = true;
      }
      //Adjacent cells
      cell.adjacentCells = findAdjacentCells(position.x, position.y);
      //adjacentMineCount
      cell.adjacentMineCount = minesAdjacentToACell(cell);
      //Add the cell to the list
      cells.add(cell);
    }

    return cells;
  }

  List<Position> findAdjacentCells(int x, int y) {
    List<Position> adjacentPositions = [];

    if (isValidPosition(x - 1, y - 1)) {
      adjacentPositions.add(Position(x - 1, y - 1));
    }
    if (isValidPosition(x - 1, y)) {
      adjacentPositions.add(Position(x - 1, y));
    }
    if (isValidPosition(x - 1, y + 1)) {
      adjacentPositions.add(Position(x - 1, y + 1));
    }

    if (isValidPosition(x, y - 1)) {
      adjacentPositions.add(Position(x, y - 1));
    }
    if (isValidPosition(x, y + 1)) {
      adjacentPositions.add(Position(x, y + 1));
    }

    if (isValidPosition(x + 1, y - 1)) {
      adjacentPositions.add(Position(x + 1, y - 1));
    }
    if (isValidPosition(x + 1, y)) {
      adjacentPositions.add(Position(x + 1, y));
    }
    if (isValidPosition(x + 1, y + 1)) {
      adjacentPositions.add(Position(x + 1, y + 1));
    }

    return adjacentPositions;
  }

  bool isValidPosition(int x, int y) {
    return x >= 0 && x < rowCount && y >= 0 && y < colCount;
  }

  int minesAdjacentToACell(Cell cell) {
    int adjacentMineCount = 0;
    cell.adjacentCells.forEach((positionAdjacent) {
      if (minePositions.contains(positionAdjacent)) {
        adjacentMineCount++; //adjacentMineCount=adjacentMineCount+1;
      }
    });
    return adjacentMineCount;
  }

  attemptToReveal(Cell cell) {
    if (cell.hasMine) {
      //Game lost, Game over
      state=GameState.lost;
    } else {
      reveal(cell);
    }
  }

  reveal(Cell cell) {
    if (cell.hasMine || cell.state == CellState.open) {
      //do nothing
    } else {
      cell.state = CellState.open;
      openCellCount++;

      if(cell.adjacentMineCount==0)
        {
          //reveal adjacent cells
          cell.adjacentCells.forEach((Position position) {
            //Get the cell at this position
            Cell thisAdjacentCell= cells.firstWhere((Cell cell) => cell.position==position);
            //Reveal this (and it adjacent cells)
            reveal(thisAdjacentCell);

          });
        }
    }

    if(openCellCount==count-mineCount){
      //Game won, update game state
      state=GameState.won;
    }
  }

  addFlag(Cell cell)
  {
    if(cell.state==CellState.close)
      {
        cell.state=CellState.flagged;
        return;
      }

    if(cell.state==CellState.flagged)
    {
      cell.state=CellState.close;
      return;
    }
  }
}
