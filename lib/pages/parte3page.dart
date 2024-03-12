import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(Parte3Page());
}

class Parte3Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buscar Universidad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UniversityListScreen(),
    );
  }
}

class UniversityListScreen extends StatefulWidget {
  @override
  _UniversityListScreenState createState() => _UniversityListScreenState();
}

class _UniversityListScreenState extends State<UniversityListScreen> {
  TextEditingController _countryController = TextEditingController();
  List<dynamic> _universities = [];
  bool _isLoading = false;

  Future<void> _fetchUniversities(String country) async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
        Uri.parse('http://universities.hipolabs.com/search?country=$country'));
    final responseData = json.decode(response.body);

    setState(() {
      _isLoading = false;
      _universities = responseData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Universidad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _countryController,
              decoration: InputDecoration(
                hintText: 'Digite un pais en ingles',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _fetchUniversities(_countryController.text.trim());
              },
              child: Text('Search'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _universities.length,
                      itemBuilder: (context, index) {
                        var university = _universities[index];
                        return ListTile(
                          title: Text(university['name']),
                          subtitle: Text(university['domains'].isNotEmpty
                              ? 'Domain: ${university['domains'][0]}'
                              : 'No domain available'),
                          onTap: () {
                            if (university['web_pages'].isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UniversityDetailScreen(
                                    university: university,
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class UniversityDetailScreen extends StatelessWidget {
  final Map<String, dynamic> university;

  UniversityDetailScreen({required this.university});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de universidad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Name: ${university['name']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              university['domains'].isNotEmpty
                  ? 'Domain: ${university['domains'][0]}'
                  : 'Dominio no disponible',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                if (university['web_pages'].isNotEmpty) {
                  launch(university['web_pages'][0]);
                }
              },
              child: Text(
                'Visitar pagina web',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
