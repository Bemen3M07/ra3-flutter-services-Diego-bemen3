import 'package:flutter_test/flutter_test.dart';
import 'package:serviciosapi/services/service_cars.dart';
import 'package:serviciosapi/model/cars.dart';

void main() {
  group('CarsApi', () {
    test('getCars devuelve una lista válida de coches', () async {
      final carHttpService = CarHttpService();

      final List<CarsModel> cars = await carHttpService.getCars();

      // Comprobaciones seguras
      expect(cars, isNotEmpty);
      expect(cars.first.id, isNotNull);
      expect(cars.first.make, isNotEmpty);
    });
  });
}