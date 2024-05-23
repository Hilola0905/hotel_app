

import 'package:equatable/equatable.dart';

class  BottomEvent extends Equatable{
  final int index;
  const  BottomEvent({required this.index});
  @override
  // TODO: implement props
  List<Object?> get props => [
    index
  ];

}