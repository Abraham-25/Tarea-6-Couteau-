import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(Parte5Page());
}

class Parte5Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WordPress News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WordPressNewsScreen(),
    );
  }
}

class WordPressNewsScreen extends StatefulWidget {
  @override
  _WordPressNewsScreenState createState() => _WordPressNewsScreenState();
}

class _WordPressNewsScreenState extends State<WordPressNewsScreen> {
  String _siteLogoUrl =
      'https://blog.myfitnesspal.com/wp-content/uploads/2023/02/MFPLogoFull-blue.png'; // URL del logotipo del sitio web
  late List<dynamic> _posts;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final response = await http.get(Uri.parse(
        'https://blog.myfitnesspal.com/wp-json/wp/v2/posts?per_page=3')); // Reemplaza 'example.com' con la URL de tu propio sitio web
    final responseData = json.decode(response.body);
    setState(() {
      _isLoading = false;
      _posts = responseData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias WordPress'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  _siteLogoUrl,
                  height:
                      100, // Ajusta la altura del logo según tus necesidades
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      var post = _posts[index];
                      return ListTile(
                        title: Text(post['title']['rendered']),
                        subtitle: Text(post['excerpt']['rendered']),
                        onTap: () {
                          var postUrl = post['https://blog.myfitnesspal.com'];
                          // Abrir el enlace en el navegador web
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
