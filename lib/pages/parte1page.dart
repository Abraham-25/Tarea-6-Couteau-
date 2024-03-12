import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(Parte1Page());
}

class Parte1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gender Predictor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GenderPredictor(),
    );
  }
}

class GenderPredictor extends StatefulWidget {
  const GenderPredictor({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GenderPredictorState createState() => _GenderPredictorState();
}

class _GenderPredictorState extends State<GenderPredictor> {
  String _name = '';
  String _gender = '';
  bool _isLoading = false;

  Future<void> _fetchGender() async {
    setState(() {
      _isLoading = true;
    });

    final response =
        await http.get(Uri.parse('https://api.genderize.io/?name=$_name'));
    final responseData = json.decode(response.body);

    setState(() {
      _isLoading = false;
      _gender = responseData['gender'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predecir genero'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Dijite su nombre, por favor',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchGender,
              child: Text('Predecir genero'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : _gender == 'Hombre'
                    ? Container(
                        width: 200,
                        height: 200,
                        color: Colors.blue,
                      )
                    : _gender == 'Mujer'
                        ? Container(
                            width: 200,
                            height: 200,
                            color: Colors.pink,
                          )
                        : Container(),
          ],
        ),
      ),
    );
  }
}
