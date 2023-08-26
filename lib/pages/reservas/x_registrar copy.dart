import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddDataReserva extends StatefulWidget {
  const AddDataReserva({Key? key}) : super(key: key);

  @override
  State<AddDataReserva> createState() => _AddDataReservaState();
}

class _AddDataReservaState extends State<AddDataReserva> {
  String? selectedRoomID;
  String? selectedClientID;
  String? selectedServiceID;
  DateTime? selectedCheckInDate;
  DateTime? selectedCheckOutDate;
  // ignore: unused_field
  final TextEditingController _nombreClienteController =
      TextEditingController();
  // ignore: unused_field
  final TextEditingController _nombreServicioController =
      TextEditingController();
  // ignore: unused_field
  final TextEditingController _numeroHabitacionController =
      TextEditingController();
  // ignore: unused_field
  final TextEditingController _fechaIngresoController = TextEditingController();
  // ignore: unused_field
  final TextEditingController _fechaSalidaController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  // Future<void> _submitForm() async {
  //   if (selectedRoomID != null &&
  //       selectedClientID != null &&
  //       selectedServiceID != null &&
  //       selectedCheckInDate != null &&
  //       selectedCheckOutDate != null) {
  //     final response = await http.post(
  //       Uri.parse(
  //           'http://10.170.83.33/bd_funhotel_flutter/adddataReservas.php'),
  //       body: {
  //         'idHabitacion': selectedRoomID!,
  //         'idCliente': selectedClientID!,
  //         'idServicio': selectedServiceID!,
  //         'fecIngreso': selectedCheckInDate!.toIso8601String(),
  //         'fecSalida': selectedCheckOutDate!.toIso8601String(),
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       print('Registro exitoso');
  //     } else {
  //       print('Error en el registro');
  //     }
  //   } else {
  //     print('Por favor completa todos los campos');
  //   }
  // }

  void addData() {
    var url = Uri.parse(
        'http://10.170.83.33/bd_funhotel_flutter/adddataReservas.php');

    http.post(url, body: {
      'idHabitacion': _numeroHabitacionController.text,
      'idCliente': _nombreClienteController.text,
      'idServicio': _nombreServicioController.text,
      'fecIngreso': _fechaIngresoController.text,
      'fecSalida': _fechaSalidaController.text,
    });
  }

  Future<List<Map<String, dynamic>>> getRoomData() async {
    final response = await http.get(
      Uri.parse(
          'http://10.170.83.33/bd_funhotel_flutter/getdataHabitaciones.php'),
    );
    final jsonData = json.decode(response.body);
    return List<Map<String, dynamic>>.from(jsonData);
  }

  Future<List<Map<String, dynamic>>> getClientData() async {
    final response = await http.get(
      Uri.parse('http://10.170.83.33/bd_funhotel_flutter/getdataClientes.php'),
    );
    final jsonData = json.decode(response.body);
    return List<Map<String, dynamic>>.from(jsonData);
  }

  Future<List<Map<String, dynamic>>> getServiceData() async {
    final response = await http.get(
      Uri.parse('http://10.170.83.33/bd_funhotel_flutter/getdataServicios.php'),
    );
    final jsonData = json.decode(response.body);
    return List<Map<String, dynamic>>.from(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        body: Form(
          key: _formkey,
          // padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Seleccionar Habitación: ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  FutureBuilder<List>(
                    future: getRoomData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<List> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Map<String, dynamic>> rooms =
                            snapshot.data as List<Map<String, dynamic>>;
                        return DropdownButton<String?>(
                          value: selectedRoomID,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedRoomID = newValue;
                            });
                          },
                          items: rooms.map<DropdownMenuItem<String?>>((room) {
                            return DropdownMenuItem<String?>(
                              value: room['id']
                                  .toString(), // Usar el ID como valor
                              child: Text(room['numeroHabitacion']
                                  .toString()), // Mostrar el número de habitación
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Seleccionar Cliente: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder<List>(
                    future: getClientData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<List> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Map<String, dynamic>> clients =
                            snapshot.data as List<Map<String, dynamic>>;
                        return DropdownButton<String?>(
                          value: selectedClientID,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedClientID = newValue;
                            });
                          },
                          items:
                              clients.map<DropdownMenuItem<String?>>((client) {
                            return DropdownMenuItem<String?>(
                              value: client['id']
                                  .toString(), // Usar el ID como valor
                              child: Text(client['primerNombre']
                                  .toString()), // Mostrar el nombre del cliente
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Seleccionar Servicio: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder<List>(
                    future: getServiceData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<List> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Map<String, dynamic>> services =
                            snapshot.data as List<Map<String, dynamic>>;
                        return DropdownButton<String?>(
                          value: selectedServiceID,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedServiceID = newValue;
                            });
                          },
                          items:
                              services.map<DropdownMenuItem<String?>>((service) {
                            return DropdownMenuItem<String?>(
                              value: service['id']
                                  .toString(), // Usar el ID como valor
                              child: Text(service['nombre']
                                  .toString()), // Mostrar el nombre del servicio
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Fecha de ingreso: "),
              ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      selectedCheckInDate = selectedDate;
                    });
                  }
                },
                child: const Text('Seleccionar Fecha de Ingreso'),
              ),
              const SizedBox(height: 20),
              const Text('Fecha de Salida:'),
              ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      selectedCheckOutDate = selectedDate;
                    });
                  }
                },
                child: const Text('Seleccionar Fecha de Salida'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addData();
                },
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
