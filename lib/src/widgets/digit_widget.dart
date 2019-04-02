import 'package:flutter/material.dart';
import 'digit_widget/pixel_widget.dart';
import 'digit_widget/pixel_widget/bloc/bloc.dart';

class DigitWidget extends StatefulWidget {
  final List<PixelBloc> pixelBlocs;
  DigitWidget(this.pixelBlocs);
  @override
  _DigitWidgetState createState() => _DigitWidgetState();
}

class _DigitWidgetState extends State<DigitWidget> {
  List<PixelBloc> get pixelBlocs => widget.pixelBlocs;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 35,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
      itemBuilder: (context, int index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: PixelWidget(
            pixelBloc: pixelBlocs[index],
          ),
        );
      },
    );
  }
}
