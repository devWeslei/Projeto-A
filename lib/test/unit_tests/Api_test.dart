import 'package:flutter_test/flutter_test.dart';
import '../../repositories/GoogleSearchAPI.dart';

void main() {
  group('GoogleSearchAPI', () {
    late GoogleSearchAPI googleSearchAPI;

    setUp(() {
      googleSearchAPI = GoogleSearchAPI();
    });

    test('search', () async {
      final results = await googleSearchAPI.search('flutter');
      expect(results, isNotNull);
      expect(results.length, greaterThan(0));
    });
  });
}
