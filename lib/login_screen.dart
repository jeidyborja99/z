// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String name = '';
String msg = '';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class UserData {
  static final UserData _instance = UserData._internal();

  factory UserData() => _instance;

  UserData._internal();

  String? name;
  // ignore: non_constant_identifier_names
  String? second_name;
  String? surname;
  // ignore: non_constant_identifier_names
  String? second_surname;
  String? email;
  String? birthday;
  String? estado;
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.1.11/bd_funhotel_flutter/login.php'), // Hola mundirijillo
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'name': _nameController.text,
          'email': _emailController.text,
        },
      ),
    );

    // print(response.body);

    var datauser = json.decode(response.body);
    print(datauser); // Verifica la respuesta del servidor en la consola

    if (datauser != null && datauser.containsKey('estado')) {
      final role =
          datauser['estado']; // Obtén el rol del usuario desde los datos
      if (role == '1') {
        Navigator.pushReplacementNamed(context, '/nav');
      } else if (role == '0') {
        Navigator.pushReplacementNamed(context, '/power');
      }
      UserData().name = datauser['name'];
      UserData().estado = datauser['estado'];
      UserData().email = datauser['email'];
      UserData().second_name = datauser['second_name'];
      UserData().second_surname = datauser['second_surname'];
      UserData().surname = datauser['surname'];
      UserData().birthday = datauser['birthday'];
      UserData().estado = datauser['estado'];
    } else {
      // Mostrar mensaje de error o manejar la respuesta incorrecta
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(231, 244, 239, 239),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/Mediano.png', // Reemplaza con la ruta de tu imagen
                  width:
                      200, // Ajusta el ancho de la imagen según tus necesidades
                  height:
                      200, // Ajusta la altura de la imagen según tus necesidades
                ),
                Positioned(
                  top: 150, // Ajusta la posición vertical de la imagen
                  child: Container(
                    color: Colors.transparent,
                    child: const Text(
                      'FunHotel',
                      style: TextStyle(
                        color: Color.fromARGB(221, 25, 25, 25),
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors
                    .white, // Cambia el color del campo de texto a tu elección
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(11),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    // initialValue: 'Mateo',
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                          Icons.mail), // Cambia el icono a tu elección
                      hintText: 'Nombre',
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 19, 19, 19)
                              .withOpacity(.7)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: Color.fromARGB(255, 53, 53,
                                54)), // Cambia el color de la línea superior a tu elección
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    // initialValue: 'admin@mateo.com',
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                          Icons.lock), // Cambia el icono a tu elección
                      hintText: 'Email',
                      hintStyle: TextStyle(
                          color:
                              Color.fromARGB(255, 17, 16, 16).withOpacity(.7)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    // obscureText: true, // Activa el modo de contraseña oculta
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: Color.fromARGB(255, 53, 53, 54)))))
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  _login();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 128, 33,
                      243), // Cambia el color del botón a tu elección
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        9), // Cambia el radio de borde a tu elección
                  ),
                ),
                child: const FittedBox(
                  child: Text(
                    'Entrar',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
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
