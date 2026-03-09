import 'linea_trajecto.dart';

class Parada {
  final String codiParada; // código identificador de la parada
  final String nomParada; // nombre de la parada
  final List<LiniaTrajecte> liniesTrajectes; // líneas que pasan por esta parada

  Parada({
    required this.codiParada,
    required this.nomParada,
    required this.liniesTrajectes,
  });

  factory Parada.fromJson(Map<String, dynamic> json) {
    return Parada(
      codiParada: json['codi_parada'] ?? '',
      nomParada: json['nom_parada'] ?? '',
      liniesTrajectes: (json['linies_trajectes'] as List<dynamic>?)
              ?.map((e) => LiniaTrajecte.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codi_parada': codiParada,
      'nom_parada': nomParada,
      'linies_trajectes': liniesTrajectes.map((e) => e.toJson()).toList(),
    };
  }
}
