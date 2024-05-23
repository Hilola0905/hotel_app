import 'package:equatable/equatable.dart';

class BottomState extends Equatable{

  final int index;
  const BottomState({required this.index});

  @override
  List<Object?> get props => [
    index
  ];

}