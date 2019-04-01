import 'dart:math' show Random;
import 'sample.dart';
export 'sample.dart';

class Perceptron {
  List<double> weights;
  Perceptron(int length) {
    _initWeights(length);
  }
  void _initWeights(int length) => this.weights = generateWeights(length);
  List<double> generateWeights(int length) {
    length += 1;
    Random random = Random();
    List<double> weights = List<double>(length);
    for (int i = 0; i < weights.length; i++) {
      weights[i] = random.nextDouble();
    }
    return weights;
  }

  double classify(List<double> inputs) => fire(inputs) > 0 ? 1 : 0;

  double fire(List<double> inputs) {
    List<double> inputsWithThreshold = [-1]..addAll(inputs);
    double output = 0;
    for (int i = 0; i < weights.length; i++) {
      output += inputsWithThreshold[i] * weights[i];
    }
    return output;
  }

  Future<void> train(
    List<Sample> samples, {
    double learningRate = 0.02,
    int epochs = 100,
  }) async {
    int epoch = 0;
    double error;
    do {
      error = 0;
      epoch++;
      samples.shuffle();
      for (int j = 0; j < samples.length; j++) {
        Sample sample = samples[j];
        List<double> inputs = sample.inputs;
        double target = sample.target;
        double output = classify(inputs);
        double sampleError = target - output;
        error += sampleError.abs();
        List<double> inputsWithThreshold = [-1]..addAll(inputs);
        for (int i = 0; i < weights.length; i++) {
          double deltaWeight =
              learningRate * sampleError * inputsWithThreshold[i];
          weights[i] += deltaWeight;
        }
      }
      print(
          'Epoch: ${epoch.toStringAsPrecision(3)} | Error: ${error.toStringAsPrecision(3)}');
    } while (error != 0 && epoch < epochs);
  }
}
