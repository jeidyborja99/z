import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:z/login_screen.dart';

class Perfil extends StatelessWidget {
  const Perfil({Key? key});

  @override
  Widget build(BuildContext context) {
    final userData = UserData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 101, 76, 216),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoCard(userData: userData),
            const SizedBox(height: 50),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Estado: ${userData.estado == '1' ? 'Activo' : 'Inactivo'}',
                  textStyle: const TextStyle(fontSize: 20),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
            ),
            const SizedBox(height: 45),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/loginPage');
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 255, 28, 12),
                  padding: EdgeInsets.symmetric(
                      horizontal: 19,
                      vertical: 12), // Ajusta el tamaño del botón
                ),
                child: Text(
                  'Cerrar sesión',
                  style: TextStyle(
                    fontSize: 19, // Ajusta el tamaño de la fuente
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoCard extends StatelessWidget {
  final UserData userData;

  const UserInfoCard({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre: ${userData.name}',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 10),
            Text(
              'Apellido: ${userData.surname}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              'Correo electrónico: ${userData.email}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              'Fecha de nacimiento: ${userData.birthday}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
