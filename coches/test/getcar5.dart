import 'package:flutter_test/flutter_test.dart';
import 'package:coches/services/service_cars.dart';
import 'package:coches/model/cars.dart';

void main() {
  group('CarsApi', () {
    test('getCars devuelve una lista válida de coches', () async {
      final carHttpService = CarHttpService();

      final List<CarsModel> cars = await carHttpService.getCars();

      // Comprobaciones 
      expect(cars[5].id, 9584);
      expect(cars[5].year, 2019);
      expect(cars[5].make, equals("Volvo"));
      expect(cars[5].model, equals("XC90"));
      expect(cars[5].type, equals("SUV"));

    });
  });
}