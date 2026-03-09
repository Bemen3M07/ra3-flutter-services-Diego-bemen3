class Accesibilitat {
  final String estatRampa; // estado de la rampa de acceso

  Accesibilitat({required this.estatRampa});

  factory Accesibilitat.fromJson(Map<String, dynamic> json) {
    return Accesibilitat(
      estatRampa: json['estat_rampa'] ?? 'SENSE_INCIDENCIA',
    );
  }

  Map<String, dynamic> toJson() {
    return {'estat_rampa': estatRampa};
  }
}

class InfoBus {
  final Accesibilitat accessibilitat;

  InfoBus({required this.accessibilitat});

  factory InfoBus.fromJson(Map<String, dynamic> json) {
    return InfoBus(
      accessibilitat: Accesibilitat.fromJson(
        json['accessibilitat'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'accessibilitat': accessibilitat.toJson()};
  }
}

class ProperBus {
  final int tempsArribada; // timestamp absolut
  final int? idBus; // identificador del bus (opcional)
  final InfoBus? infoBus; // información del bus (opcional)

  ProperBus({
    required this.tempsArribada,
    this.idBus,
    this.infoBus,
  });

  factory ProperBus.fromJson(Map<String, dynamic> json) {
    return ProperBus(
      tempsArribada: json['temps_arribada'] as int? ?? 0,
      idBus: json['id_bus'] as int?,
      infoBus: json['info_bus'] != null
          ? InfoBus.fromJson(json['info_bus'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temps_arribada': tempsArribada,
      if (idBus != null) 'id_bus': idBus,
      if (infoBus != null) 'info_bus': infoBus!.toJson(),
    };
  }

  /// Calcula los minutos restantes para la llegada del bus
  int minutsRestants() {
    final now = DateTime.now().millisecondsSinceEpoch;
    return ((tempsArribada - now) / 60000).round();
  }
}
