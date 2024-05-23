
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bottom_event.dart';
import 'bottom_state.dart';

class BottomBloc extends Bloc<BottomEvent,BottomState>{
  BottomBloc():super(const BottomState(index: 0)){
    on<BottomEvent>(_changeIndex);
  }
  _changeIndex(BottomEvent event,  emit ){
    emit(BottomState(index: event.index));
  }
}