import 'package:minesweeper/models/position.dart';

enum CellState{
  open,
  close,
  flagged
}

class Cell{
  Position position;
  bool hasMine=false;
  int adjacentMineCount=0;
  List<Position> adjacentCells=[];
  CellState state=CellState.close;
  Cell(this.position);
}