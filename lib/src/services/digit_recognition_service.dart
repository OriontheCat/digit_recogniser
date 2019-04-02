import 'digit_recognition_service/perceptron.dart';
import 'dart:math' show Random;

class DigitRecognitionService {
  static const List<double> zero = [
    0.0,
    1.0,
    1.0,
    1.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    1.0,
    1.0,
    1.0,
    0.0,
  ];
  static const List<double> one = [
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    0.0,
    0.0,
    1.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    1.0,
    1.0,
    1.0,
    1.0,
    1.0,
  ];
  static const List<double> two = [
    0.0,
    1.0,
    1.0,
    1.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    1.0,
    1.0,
    1.0,
  ];
  static const List<double> three = [
    0.0,
    1.0,
    1.0,
    1.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    1.0,
    1.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    1.0,
    1.0,
    1.0,
    0.0,
  ];
  static const List<double> four = [
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    1.0,
    1.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
  ];
  static const List<double> five = [
    1.0,
    1.0,
    1.0,
    1.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    1.0,
    1.0,
    1.0,
    0.0,
  ];
  static const List<double> six = [
    0.0,
    1.0,
    1.0,
    1.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    1.0,
    1.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    1.0,
    1.0,
    1.0,
    0.0,
  ];
  static const List<double> seven = [
    1.0,
    1.0,
    1.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
  ];
  static const List<double> eight = [
    0.0,
    1.0,
    1.0,
    1.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    1.0,
    1.0,
    1.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    1.0,
    1.0,
    1.0,
    0.0,
  ];
  static const List<double> nine = [
    0.0,
    1.0,
    1.0,
    1.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    1.0,
    1.0,
    1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
  ];
  static const List<List<double>> digits = [
    zero,
    one,
    two,
    three,
    four,
    five,
    six,
    seven,
    eight,
    nine
  ];
  List<Perceptron> _perceptrons = List<Perceptron>(10);
  List<List<Sample>> samples = [];
  DigitRecognitionService() {
    for (var i = 0; i < _perceptrons.length; i++) {
      _perceptrons[i] = Perceptron(35);
    }
    generateSamples();
    train();
  }
  void generateSamples() {
    samples = List<List<Sample>>(10);
    for (int i = 0; i < samples.length; i++) {
      samples[i] = [];
      for (var j = 0; j < digits.length; j++) {
        List<Sample> tempSamples = [];
        double target = i == j ? 1 : 0;
        List<double> pristineInputs = List.from(digits[j]);
        Sample pristineSample = Sample(pristineInputs, target);
        tempSamples.add(pristineSample);
        for (int k = 1; k < 30; k++) {
          List<double> inputs = List.from(digits[j]);
          inputs = addNoiseToInputs(inputs, 0.2);
          Sample sample = Sample(inputs, target);
          tempSamples.add(sample);
        }
        samples[i].addAll(tempSamples);
      }
    }
    this.samples = samples;
  }

  static double addNoiseToDouble(double d, double threshold) {
    Random r = Random();
    double random = 0.5 - r.nextDouble();
    if (random.abs() <= threshold) {
      d += random;
    }
    if (d > 1) {
      d = 1;
    }
    if (d < 0) {
      d = 0;
    }
    return d;
  }

  static List<double> addNoiseToInputs(List<double> inputs, double threshold) {
    for (int i = 0; i < inputs.length; i++) {
      inputs[i] = addNoiseToDouble(inputs[i], threshold);
    }
    return inputs;
  }

  void train() {
    for (var i = 0; i < _perceptrons.length; i++) {
      Perceptron perceptron = _perceptrons[i];
      perceptron.train(samples[i]);
    }
  }

  List<double> classify(List<double> inputs) {
    List<double> oneHotVector = List<double>(10);
    for (var i = 0; i < oneHotVector.length; i++) {
      oneHotVector[i] = _perceptrons[i].classify(inputs);
    }
    return oneHotVector;
  }
}
