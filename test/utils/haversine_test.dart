import 'package:flutter_test/flutter_test.dart';
import 'package:metrowake/utils/haversine.dart';

void main() {
  group('Haversine Distance Calculation', () {
    test('should return 0 for same coordinates', () {
      final distance = Haversine.distanceInMeters(28.6328, 77.2197, 28.6328, 77.2197);
      expect(distance, closeTo(0, 0.1));
    });

    test('should calculate distance between Rajiv Chowk and Mandi House (~1km)', () {
      // Rajiv Chowk: 28.6328, 77.2197
      // Mandi House: 28.6259, 77.2346
      final distance = Haversine.distanceInMeters(28.6328, 77.2197, 28.6259, 77.2346);
      // Should be approximately 1.5-2km
      expect(distance, greaterThan(500));
      expect(distance, lessThan(3000));
    });

    test('should calculate distance between Rajiv Chowk and Kashmere Gate (~4km)', () {
      // Rajiv Chowk: 28.6328, 77.2197
      // Kashmere Gate: 28.6675, 77.2275
      final distance = Haversine.distanceInKm(28.6328, 77.2197, 28.6675, 77.2275);
      expect(distance, greaterThan(2));
      expect(distance, lessThan(6));
    });

    test('should calculate distance between Dwarka Sec 21 and Noida Electronic City (~55km)', () {
      // Dwarka Sector 21: 28.5521, 77.0581
      // Noida Electronic City: 28.5567, 77.3764
      final distance = Haversine.distanceInKm(28.5521, 77.0581, 28.5567, 77.3764);
      expect(distance, greaterThan(20));
      expect(distance, lessThan(50));
    });

    test('should be symmetric (A→B == B→A)', () {
      final d1 = Haversine.distanceInMeters(28.6328, 77.2197, 28.6675, 77.2275);
      final d2 = Haversine.distanceInMeters(28.6675, 77.2275, 28.6328, 77.2197);
      expect(d1, closeTo(d2, 0.01));
    });
  });
}
