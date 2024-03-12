import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
import 'package:flip_card/flip_card.dart';
import 'package:prueba5/pages/parte1page.dart';
import 'package:prueba5/pages/parte2page.dart';
import 'package:prueba5/pages/parte3page.dart';
import 'package:prueba5/pages/parte4page.dart';
import 'package:prueba5/pages/parte5page.dart';
import 'package:prueba5/pages/parte6page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //return const Placeholder();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Builder(
              builder: (context) => IconButton(
                    icon: const Icon(
                      Icons.menu,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  )),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: const Text("INICIO"),
          centerTitle: true,
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 51, 49, 49),
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: ListView(
              children: [
                DrawerHeader(child: Image.asset('lib/images/caja.jpg')),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 25.0),
                  leading: const Icon(Icons.accessibility, color: Colors.white),
                  title: const Text(
                    'Predecir genero',
                    style: TextStyle(color: Color.fromARGB(238, 255, 255, 255)),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Parte1Page()));
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 25.0),
                  leading: const Icon(Icons.ads_click, color: Colors.white),
                  title: const Text(
                    'Predecir edad',
                    style: TextStyle(color: Color.fromARGB(238, 255, 255, 255)),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Parte2Page()));
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 25.0),
                  leading: const Icon(Icons.account_box, color: Colors.white),
                  title: const Text(
                    'Universidad',
                    style: TextStyle(color: Color.fromARGB(238, 255, 255, 255)),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Parte3Page()));
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 25.0),
                  leading: const Icon(Icons.all_inclusive, color: Colors.white),
                  title: const Text(
                    'Clima',
                    style: TextStyle(color: Color.fromARGB(238, 255, 255, 255)),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Parte4Page()));
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 25.0),
                  leading:
                      const Icon(Icons.assignment_sharp, color: Colors.white),
                  title: const Text(
                    'WordPress',
                    style: TextStyle(color: Color.fromARGB(238, 255, 255, 255)),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Parte5Page()));
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 25.0),
                  leading:
                      const Icon(Icons.assignment_sharp, color: Colors.white),
                  title: const Text(
                    'Acerca de',
                    style: TextStyle(color: Color.fromARGB(238, 255, 255, 255)),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Parte6Page()));
                  },
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL,
            speed: 700,
            front: Container(
              width: 315,
              height: 600,
              //color: Colors.amber,
              child: Image.asset('lib/images/caja.jpg', fit: BoxFit.fitHeight),
            ),
            back: Container(
              width: 315,
              height: 600,
              color: Colors.black,
              child: const Center(
                  child: Text(
                'Caja de herramientas',
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
