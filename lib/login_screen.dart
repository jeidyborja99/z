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
      Uri.parse('http://192.168.1.54/bd_funhotel_flutter/login.php'),
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
      backgroundColor:
          Colors.blueGrey, // Cambia el color de fondo a tu elección
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Iniciar sesión',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors
                    .white, // Cambia el color del campo de texto a tu elección
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    // initialValue: 'Mateo',
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.mail), // Cambia el icono a tu elección
                      hintText: 'Nombre',
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.7)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: Colors
                                .grey), // Cambia el color de la línea superior a tu elección
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    // initialValue: 'admin@mateo.com',
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.lock), // Cambia el icono a tu elección
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.7)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    // obscureText: true, // Activa el modo de contraseña oculta
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  _login();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cambia el color del botón a tu elección
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // Cambia el radio de borde a tu elección
                  ),
                ),
                child: const FittedBox(
                  child: Text(
                    'Entrar',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
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
