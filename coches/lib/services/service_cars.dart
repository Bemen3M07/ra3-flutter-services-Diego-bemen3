import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/cars.dart';

class CarHttpService {
  final String _serverUrl = "https://car-data.p.rapidapi.com";
  final String _headerKey = "49d8315746msha3bd66e67a096bbp15fc81jsnd5c084af686d";
  final String _headerHost = "car-data.p.rapidapi.com";

  List<CarsModel> _carsModelFromJson(String str) {
    final List<dynamic> jsonData = json.decode(str);
    return jsonData //builder para convertir la respuesta de la api json en una lista de objetos 
        .map((e) => CarsModel.fromMaptoCarObject(e))
        .toList();
  }

  Future<List<CarsModel>> getCars() async {
    final url = Uri.parse("$_serverUrl/cars");

    final response = await http.get(
      url,
      headers: { //headers para la autenticacion en la API
        "x-rapidapi-key": _headerKey,
        "x-rapidapi-host": _headerHost,
      },
    );

    if (response.statusCode == 200) { // si la conexion es exitosa devuelve la lista de coches
      return _carsModelFromJson(response.body);
    } else {
      throw Exception("Error ${response.statusCode}");
    }
  }
}
