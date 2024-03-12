import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(Parte2Page());
}

class Parte2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Predictor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InputScreen(),
    );
  }
}

class InputScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predecidor de edad'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Introduce tu nombre',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ResultScreen(name: _nameController.text),
                    ),
                  );
                },
                child: Text('Predecir edad'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatefulWidget {
  final String name;

  ResultScreen({required this.name});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int? _age;
  String _ageGroup = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _fetchAge();
    });
  }

  Future<void> _fetchAge() async {
    final response =
        await http.get(Uri.parse('https://api.agify.io/?name=${widget.name}'));
    final responseData = json.decode(response.body);

    setState(() {
      _isLoading = false;
      _age = responseData['age'] as int?;
      _determineAgeGroup();
    });
  }

  void _determineAgeGroup() {
    if (_age != null) {
      if (_age! < 30) {
        _ageGroup = 'Joven';
      } else if (_age! >= 30 && _age! < 60) {
        _ageGroup = 'Adulto';
      } else {
        _ageGroup = 'Viejos';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado de predicion de edad'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Predecir edad: ${_age ?? "Unknown"}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Grupo de edad:  $_ageGroup',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  _buildImage(),
                ],
              ),
      ),
    );
  }

  Widget _buildImage() {
    if (_ageGroup == 'Joven') {
      return Image.asset(
        'lib/images/joven.png', // Ruta de la imagen para personas jóvenes
        width: 150,
        height: 150,
      );
    } else if (_ageGroup == 'Adulto') {
      return Image.asset(
        'lib/images/adulto.png', // Ruta de la imagen para personas adultas
        width: 150,
        height: 150,
      );
    } else if (_ageGroup == 'Viejos') {
      return Image.asset(
        'lib/images/viejos.png', // Ruta de la imagen para personas ancianas
        width: 150,
        height: 150,
      );
    } else {
      return Container();
    }
  }
}
