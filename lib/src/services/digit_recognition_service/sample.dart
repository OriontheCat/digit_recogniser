import 'package:meta/meta.dart';

@immutable
class Sample {
  final List<double> _inputs;
  final double _target;

  List<double> get inputs => _inputs;
  double get target => _target;
  const Sample(this._inputs, this._target);
}
