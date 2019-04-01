import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class PixelState extends Equatable {
  final double value;
  PixelState(this.value) : super([value]);
}
