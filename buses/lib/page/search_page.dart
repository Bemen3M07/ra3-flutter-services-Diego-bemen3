import 'package:flutter/material.dart';
import 'package:buses/model/linea_trajecto.dart';
import 'package:buses/service/bus_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final BusService _service = BusService();

  bool _loading = false;
  String? _error;
  List<LiniaTrajecte> _results = [];

  Future<void> _search() async {
    final code = _controller.text.trim();
    if (code.isEmpty) return;

    setState(() {
      _loading = true;
      _error = null;
      _results = [];
    });

    try {
      final lines = await _service.fetchLiniesForParada(code);
      setState(() {
        _results = lines;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 161, 154), 
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Buscar parada'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [

                /// TEXTFIELD
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Código de parada',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _search(),
                  ),
                ),

                const SizedBox(width: 10),

                /// BOTON BUSCAR
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 113, 113),
                    padding: const EdgeInsets.symmetric( // boton mas grande
                      horizontal: 26,
                      vertical: 22,
                    ),
                    shape: RoundedRectangleBorder( // bordes menos redondeados
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: _loading ? null : _search,
                  child: const Text('Buscar', 
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), 
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 16),

            if (_loading)
              const Center(child: CircularProgressIndicator()),

            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),

            if (!_loading && _error == null)
              Expanded(
                child: _results.isEmpty
                    ? const Center(
                        child: Text('Ingrese un código y presione buscar'),
                      )
                    : GridView.builder(
                        itemCount: _results.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 5.2,
                        ),
                        itemBuilder: (context, index) {
                          final line = _results[index];
                          return _LineTile(line: line);
                        },
                      ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LineTile extends StatelessWidget {
  final LiniaTrajecte line;

  const _LineTile({required this.line});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [

            /// IMAGEN BUS
            Image.asset(
              "assets/images/bus_${line.transitNamespace}.png",
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),

            const SizedBox(width: 10),

            /// INFORMACIÓN
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// LINEA + BADGE
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      /// LINEA (izquierda)
                      Expanded(
                        child: Text(
                          '${line.nomLinia} → ${line.destiTrajecte}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(width: 8),

                      /// BADGE BUS (derecha)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: line.transitNamespace == 'bus'
                              ? Colors.blue
                              : Colors.green,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          line.transitNamespace.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  /// TIEMPOS
                  if (line.propersBusos.isEmpty)
                    const Text(
                      "Sin buses próximos",
                      style: TextStyle(color: Colors.orange, fontSize: 12),
                    )
                  else
                    ...line.propersBusos.take(2).map((bus) {
                      final min = bus.minutsRestants();
                      final busInfo =
                          bus.idBus != null ? 'Bus ${bus.idBus}' : 'Bus';

                      return Text(
                        "$busInfo: $min min",
                        style: TextStyle(
                          color: min <= 5 ? Colors.red : const Color.fromARGB(255, 0, 0, 0),
                          fontWeight:
                              min <= 5 ? FontWeight.bold : FontWeight.normal,
                          fontSize: 14,
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}