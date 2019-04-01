main(List<String> args) {
  String digitString = '''
 sss 
s    
ssss 
s   s
 sss ''';
  List<String> rows = digitString.split('\n');
  List<List<double>> digit = [];
  rows.forEach((String row) {
    List<String> pixelStrings = row.split('');
    List<double> pixels = [];
    pixelStrings.forEach((String pixelString) {
      pixels.add(pixelString == 's' ? 1 : 0);
    });
    digit.add(pixels);
  });
  print(digit);
}
