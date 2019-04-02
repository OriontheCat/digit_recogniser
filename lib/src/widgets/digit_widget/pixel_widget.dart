import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pixel_widget/bloc/bloc.dart';

class PixelWidget extends StatefulWidget {
  final PixelBloc pixelBloc;
  PixelWidget({@required this.pixelBloc});
  @override
  _PixelWidgetState createState() => _PixelWidgetState(pixelBloc);
}

class _PixelWidgetState extends State<PixelWidget> {
  PixelBloc _pixelBloc;
  _PixelWidgetState(this._pixelBloc);
  double get value => _pixelBloc.currentState.value;
  set value(double value) => _pixelBloc.dispatch(SetValue(value));

  Color valueToColor(double value) {
    int shade = 255 - (255 * value).round();
    if (shade > 255) {
      shade = 255;
    }
    if (shade < 0) {
      shade = 0;
    }
    return Color.fromARGB(255, shade, shade, shade);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: BlocBuilder(
          bloc: _pixelBloc,
          builder: (BuildContext context, PixelState state) {
            return GestureDetector(
              onTap: () {
                _pixelBloc.dispatch(SetValue(1));
              },
              onDoubleTap: () {
                _pixelBloc.dispatch(SetValue(0));
              },
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text('Set pixel value'),
                      children: <Widget>[
                        BlocBuilder(
                          bloc: _pixelBloc,
                          builder: (BuildContext context, PixelState state) {
                            debugPrint(state.value.toString());
                            return Slider(
                              divisions: 256,
                              value: state.value,
                              onChanged: (double value) =>
                                  _pixelBloc.dispatch(SetValue(value)),
                            );
                          },
                        )
                      ],
                    );
                  },
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.0),
                child: Container(
                  color: valueToColor(state.value),
                ),
              ),
            );
          },
        ));
  }

  @override
  void dispose() {
    _pixelBloc.dispose();
    super.dispose();
  }
}
