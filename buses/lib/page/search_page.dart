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
      appBar: AppBar(
        title: const Text('Buscar parada'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Código de parada',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _search(),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _search,
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 16),
            if (_loading) const Center(child: CircularProgressIndicator()),
            if (_error != null) ...[
              Text(_error!, style: const TextStyle(color: Colors.red))
            ],
            if (!_loading && _error == null)
              Expanded(
                child: _results.isEmpty
                    ? const Center(
                        child: Text('Ingrese un código y presione buscar'),
                      )
                    : GridView.builder(
                        itemCount: _results.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.4,
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
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// BUS
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: line.transitNamespace == 'bus'
                    ? Colors.blue
                    : Colors.green,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                line.transitNamespace.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            /// IMAGEN + INFO
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// COLUMNA IMAGEN
                Image.asset(
                  "assets/images/bus_${line.transitNamespace}.png",
                  width: 140,
                  height: 140,
                  fit: BoxFit.contain,
                ),

                const SizedBox(width: 10),

                /// COLUMNA INFORMACIÓN
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        '${line.nomLinia} → ${line.destiTrajecte}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 6),

                      if (line.propersBusos.isEmpty)
                        const Text(
                          "Sin buses próximos",
                          style: TextStyle(color: Colors.orange),
                        )
                      else
                        ...line.propersBusos.take(3).map((bus) {
                          final min = bus.minutsRestants();
                          final busInfo =
                              bus.idBus != null ? 'Bus ${bus.idBus}' : 'Bus';

                          return Text(
                            "$busInfo: $min min",
                            style: TextStyle(
                              color: min <= 5 ? Colors.red : Colors.white,
                              fontWeight: min <= 5
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          );
                        }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}