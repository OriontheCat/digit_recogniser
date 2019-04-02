import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'src/services/digit_recognition_service.dart';
import 'src/widgets/digit_widget/pixel_widget/bloc/bloc.dart';
import 'package:digit_recogniser/src/widgets/digit_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digit Recogniser',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Digit Recogniser'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DigitRecognitionService _digitRecognitionService;
  List<PixelBloc> pixelBlocs;
  @override
  void initState() {
    pixelBlocs = List<PixelBloc>(35);
    for (int i = 0; i < pixelBlocs.length; i++) {
      pixelBlocs[i] = PixelBloc(1);
    }
    _digitRecognitionService = DigitRecognitionService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                AspectRatio(
                    aspectRatio: 5.0 / 7.0, child: DigitWidget(pixelBlocs)),
                RaisedButton(
                  onPressed: () => _digitRecognitionService.generateSamples(),
                  child: Text('Generate samples'),
                ),
                RaisedButton(
                  onPressed: () => _digitRecognitionService.train(),
                  child: Text('Train'),
                ),
                RaisedButton(
                  onPressed: () {
                    for (int i = 0; i < pixelBlocs.length; i++) {
                      pixelBlocs[i].dispatch(SetValue(
                          DigitRecognitionService.addNoiseToDouble(
                              pixelBlocs[i].currentState.value, 0.2)));
                    }
                  },
                  child: Text('Add noise'),
                ),
                RaisedButton(
                  child: Text('Reset values'),
                  onPressed: () {
                    for (int i = 0; i < pixelBlocs.length; i++) {
                      pixelBlocs[i].dispatch(SetValue(0));
                    }
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DigitDialog(
                            pixelBlocs: pixelBlocs,
                          );
                        });
                  },
                  child: Text('Set digit'),
                ),
                RaisedButton(
                  onPressed: () {
                    List<double> inputs = List<double>(35);
                    for (int i = 0; i < inputs.length; i++) {
                      inputs[i] = pixelBlocs[i].currentState.value;
                    }
                    List<double> oneHotVector =
                        _digitRecognitionService.classify(inputs);
                    String displayString = 'Digit could be: ';
                    if (!oneHotVector.any((double d) => d >= 1)) {
                      displayString += 'nothing (Error)';
                    } else {
                      for (int i = 0; i < oneHotVector.length; i++) {
                        if (oneHotVector[i] >= 1) {
                          displayString += '$i, ';
                        }
                      }
                    }

                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Text(displayString),
                          );
                        });
                  },
                  child: Text('Classify'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DigitDialog extends StatefulWidget {
  final List<PixelBloc> pixelBlocs;
  const DigitDialog({
    Key key,
    @required this.pixelBlocs,
  }) : super(key: key);

  @override
  _DigitDialogState createState() => _DigitDialogState();
}

class _DigitDialogState extends State<DigitDialog> {
  int digitIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Pick the digit'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: NumberPicker.integer(
            initialValue: digitIndex,
            minValue: 0,
            maxValue: 9,
            infiniteLoop: true,
            onChanged: (num value) => setState(() => digitIndex = value as int),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
              List<double> digit = DigitRecognitionService.digits[digitIndex];
              for (int i = 0; i < digit.length; i++) {
                widget.pixelBlocs[i].dispatch(SetValue(digit[i]));
              }
              Navigator.pop(context);
            },
            child: Text('Set'),
          ),
        ),
      ],
    );
  }
}
