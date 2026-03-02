import 'package:flutter_test/flutter_test.dart';
import 'package:metrowake/data/metro_data_provider.dart';
import 'package:metrowake/services/route_service.dart';

void main() {
  late MetroDataProvider dataProvider;
  late RouteService routeService;

  setUp(() async {
    dataProvider = MetroDataProvider();
    await dataProvider.initialize();
    routeService = RouteService(dataProvider);
  });

  group('Route Service', () {
    test('should find direct route on Blue Line', () {
      final start = dataProvider.getStationById('bl_01'); // Dwarka Sec 21
      final end = dataProvider.getStationById('bl_29');   // Rajiv Chowk
      expect(start, isNotNull);
      expect(end, isNotNull);

      final journey = routeService.findRoute(start!, end!);
      expect(journey, isNotNull);
      expect(journey!.isDirect, isTrue);
      expect(journey.interchanges, isEmpty);
      expect(journey.allStations.first.id, equals('bl_01'));
      expect(journey.allStations.last.id, equals('bl_29'));
    });

    test('should find direct route in reverse direction', () {
      final start = dataProvider.getStationById('bl_49'); // Noida Electronic City
      final end = dataProvider.getStationById('bl_34');   // Yamuna Bank
      expect(start, isNotNull);
      expect(end, isNotNull);

      final journey = routeService.findRoute(start!, end!);
      expect(journey, isNotNull);
      expect(journey!.isDirect, isTrue);
      expect(journey.allStations.first.id, equals('bl_49'));
      expect(journey.allStations.last.id, equals('bl_34'));
    });

    test('should find interchange route between Blue and Yellow (via Rajiv Chowk)', () {
      final start = dataProvider.getStationById('bl_01'); // Dwarka Sec 21 (Blue)
      final end = dataProvider.getStationById('yl_37');   // HUDA City Centre (Yellow)
      expect(start, isNotNull);
      expect(end, isNotNull);

      final journey = routeService.findRoute(start!, end!);
      expect(journey, isNotNull);
      expect(journey!.isDirect, isFalse);
      expect(journey.interchanges, isNotEmpty);
      // Should interchange at Rajiv Chowk
      expect(journey.interchanges.first.station.name, equals('Rajiv Chowk'));
    });

    test('should calculate estimated journey time', () {
      final start = dataProvider.getStationById('bl_01');
      final end = dataProvider.getStationById('bl_10');
      final journey = routeService.findRoute(start!, end!);
      expect(journey, isNotNull);
      expect(journey!.estimatedTimeMinutes, greaterThan(0));
    });
  });

  group('Data Provider', () {
    test('should have stations loaded', () {
      expect(dataProvider.stations, isNotEmpty);
      expect(dataProvider.stations.length, greaterThan(100));
    });

    test('should have lines loaded', () {
      expect(dataProvider.lines, isNotEmpty);
    });

    test('should search stations by name', () {
      final results = dataProvider.searchStations('Rajiv');
      expect(results, isNotEmpty);
      expect(results.any((s) => s.name.contains('Rajiv')), isTrue);
    });

    test('should get interchange stations', () {
      final interchanges = dataProvider.getInterchangeStations();
      expect(interchanges, isNotEmpty);
      expect(interchanges.any((s) => s.name == 'Rajiv Chowk'), isTrue);
    });
  });
}
