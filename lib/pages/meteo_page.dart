import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/drawer_menu.dart';

class MeteoPage extends StatefulWidget {
  const MeteoPage({super.key});

  @override
  State<MeteoPage> createState() => _MeteoPageState();
}

class _MeteoPageState extends State<MeteoPage> {
  final _cities = const {
    'Casablanca': {'lat': 33.5731, 'lon': -7.5898},
    'Rabat':      {'lat': 34.0209, 'lon': -6.8416},
    'Marrakech':  {'lat': 31.6295, 'lon': -7.9811},
    'Paris':      {'lat': 48.8566, 'lon': 2.3522},
  };

  String _selected = 'Casablanca';
  bool _loading = false;
  String? _error;
  Map<String, dynamic>? _current;

  Future<void> _fetch() async {
    final lat = _cities[_selected]!['lat']!;
    final lon = _cities[_selected]!['lon']!;
    final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': '$lat',
      'longitude': '$lon',
      'current_weather': 'true', // renvoie temperature, windspeed, weathercode, time
      'timezone': 'auto',
    });

    setState(() {
      _loading = true;
      _error = null;
      _current = null;
    });

    try {
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body) as Map<String, dynamic>;
        setState(() => _current = json['current_weather'] as Map<String, dynamic>?);
      } else {
        setState(() => _error = 'Erreur ${res.statusCode}');
      }
    } catch (e) {
      setState(() => _error = 'Erreur réseau: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  String _codeToText(int code) {
    // mapping minimal
    if ([0].contains(code)) return 'Ciel clair';
    if ([1, 2, 3].contains(code)) return 'Partiellement nuageux';
    if ([45, 48].contains(code)) return 'Brouillard';
    if ([51, 53, 55].contains(code)) return 'Bruine';
    if ([61, 63, 65].contains(code)) return 'Pluie';
    if ([71, 73, 75].contains(code)) return 'Neige';
    if ([80, 81, 82].contains(code)) return 'Averses';
    if ([95, 96, 99].contains(code)) return 'Orage';
    return 'Inconnu';
    // (Codes: https://open-meteo.com/en/docs#weathervariables)
  }

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/meteo'),
      appBar: AppBar(title: const Text('Météo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selected,
                    items: _cities.keys.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (v) => setState(() => _selected = v!),
                    decoration: const InputDecoration(labelText: 'Ville'),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: _loading ? null : _fetch,
                  child: const Text('Actualiser'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_loading) const LinearProgressIndicator(),
            if (_error != null) Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(_error!, style: const TextStyle(color: Colors.red)),
            ),
            if (_current != null) Card(
              child: ListTile(
                leading: const Icon(Icons.thermostat),
                title: Text('$_selected'),
                subtitle: Text(_codeToText((_current!['weathercode'] as num).toInt())),
                trailing: Text('${_current!['temperature']}°C'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
