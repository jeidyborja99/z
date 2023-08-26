import 'package:flutter/material.dart';

class Power extends StatelessWidget {
  const Power({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Reservas de Hotel'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', // Ruta de tu logo de hotel
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              '¡Bienvenido a nuestro Sistema de Reservas!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Explora nuestras opciones y revisa las reservas registradas',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
