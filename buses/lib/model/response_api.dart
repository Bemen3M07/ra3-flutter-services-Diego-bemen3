import 'parada.dart';

class ResponseApi {
  final int timestamp; // timestamp de la consulta
  final List<Parada> parades; // lista de paradas

  ResponseApi({
    required this.timestamp,
    required this.parades,
  });

  factory ResponseApi.fromJson(Map<String, dynamic> json) {
    return ResponseApi(
      timestamp: json['timestamp'] as int? ?? 0,
      parades: (json['parades'] as List<dynamic>?)
              ?.map((e) => Parada.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'parades': parades.map((e) => e.toJson()).toList(),
    };
  }
}
