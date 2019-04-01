import 'package:flutter/material.dart';
import 'digit_widget/pixel_widget.dart';
import 'digit_widget/pixel_widget/bloc/bloc.dart';

class DigitWidget extends StatefulWidget {
  @override
  _DigitWidgetState createState() => _DigitWidgetState();
}

class _DigitWidgetState extends State<DigitWidget> {
  List<PixelBloc> _pixelBlocs;
  @override
  void initState() {
    _pixelBlocs = List<PixelBloc>(35);
    for (int i = 0; i < _pixelBlocs.length; i++) {
      _pixelBlocs[i] = PixelBloc(1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 35,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
      itemBuilder: (context, int index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: PixelWidget(
            pixelBloc: _pixelBlocs[index],
          ),
        );
      },
    );
  }
}
