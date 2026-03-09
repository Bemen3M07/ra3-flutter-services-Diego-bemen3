import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:buses/model/response_api.dart';
import 'package:buses/model/parada.dart';
import 'package:buses/model/linea_trajecto.dart';


class BusService {

  static const String _baseUrl = 'https://api.tmb.cat/v1/itransit/bus';


  static const String _appId = 'ad369614';


  static const String _appKey = '7d0105e02b9a2bd25f15fe2af6cce536';


  Future<Parada?> fetchParada(String paradaCode) async {
    final uri = Uri.parse('$_baseUrl/parades/$paradaCode?app_id=$_appId&app_key=$_appKey');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final apiResponse = ResponseApi.fromJson(data);
      
      if (apiResponse.parades.isNotEmpty) {
        return apiResponse.parades.first;
      }
      return null;
    } else {
      throw Exception('Fallo al cargar los buses de la parada $paradaCode');
    }
  }


  Future<List<LiniaTrajecte>> fetchLiniesForParada(String paradaCode) async {
    final parada = await fetchParada(paradaCode);
    return parada?.liniesTrajectes ?? [];
  }
}
