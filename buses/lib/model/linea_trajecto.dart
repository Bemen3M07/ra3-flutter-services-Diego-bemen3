import 'proper_bus.dart';

class LiniaTrajecte {
  final int idOperador; // id del operador
  final String transitNamespace; // 'bus' = TMB, 'amb' = AMB
  final dynamic codiLinia; // código de línea (puede ser string o int)
  final String nomLinia; // nombre de línea visible
  final int idSentit; // 1 = Anada, 2 = Tornada
  final String codiTrajecte; // código del trayecto
  final String destiTrajecte; // destino del trayecto
  final List<ProperBus> propersBusos; // lista de próximos buses

  LiniaTrajecte({
    required this.idOperador,
    required this.transitNamespace,
    required this.codiLinia,
    required this.nomLinia,
    required this.idSentit,
    required this.codiTrajecte,
    required this.destiTrajecte,
    required this.propersBusos,
  });

  factory LiniaTrajecte.fromJson(Map<String, dynamic> json) {
    return LiniaTrajecte(
      idOperador: json['id_operador'] as int? ?? 0,
      transitNamespace: json['transit_namespace'] as String? ?? '',
      codiLinia: json['codi_linia'], // puede ser string o int
      nomLinia: json['nom_linia'] as String? ?? '',
      idSentit: json['id_sentit'] as int? ?? 1,
      codiTrajecte: json['codi_trajecte'] as String? ?? '',
      destiTrajecte: json['desti_trajecte'] as String? ?? '',
      propersBusos: (json['propers_busos'] as List<dynamic>?)
              ?.map((e) => ProperBus.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_operador': idOperador,
      'transit_namespace': transitNamespace,
      'codi_linia': codiLinia,
      'nom_linia': nomLinia,
      'id_sentit': idSentit,
      'codi_trajecte': codiTrajecte,
      'desti_trajecte': destiTrajecte,
      'propers_busos': propersBusos.map((e) => e.toJson()).toList(),
    };
  }
}
