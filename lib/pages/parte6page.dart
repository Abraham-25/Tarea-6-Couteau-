import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
//import 'package:apptematica/main.dart';

class Parte6Page extends StatelessWidget {
  const Parte6Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Contratame'),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Center(
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL,
            speed: 700,
            front: Container(
              width: 315,
              height: 600,
              //color: Colors.amber,
              child: Image.asset('lib/images/yo.jpeg', fit: BoxFit.fitHeight),
            ),
            back: Container(
              width: 315,
              height: 600,
              color: Colors.black,
              child: const Center(
                  child: Text(
                "Abraham Wilfredo Infante Rosario" "20209807@itla.edu.do",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
