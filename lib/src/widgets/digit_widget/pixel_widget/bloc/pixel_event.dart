import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PixelEvent extends Equatable {
  PixelEvent([List props = const []]) : super(props);
}

class SetValue extends PixelEvent {
  final double value;
  SetValue(this.value) : super([value]);
}
