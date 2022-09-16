import 'package:equatable/equatable.dart';

class Position extends Equatable{
  int x;
  int y;
  int index;

  Position(this.x, this.y,[this.index=-1]);

  @override
  List<Object?> get props => [x,y];
}