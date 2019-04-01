import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PixelBloc extends Bloc<PixelEvent, PixelState> {
  final double initialValue;
  PixelBloc(this.initialValue);
  @override
  PixelState get initialState => PixelState(initialValue);

  @override
  Stream<PixelState> mapEventToState(
    PixelEvent event,
  ) async* {
    if (event is SetValue) {
      yield PixelState(event.value);
    }
  }
}
