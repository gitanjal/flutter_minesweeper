import 'package:equatable/equatable.dart';

class Position extends Equatable{
  int x,y;
  Position(this.x, this.y);

  @override
  List<Object?> get props => [x,y];

}