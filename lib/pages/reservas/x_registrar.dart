import 'package:flutter/material.dart';
// http
import 'package:http/http.dart' as http;

class AddDataReserva extends StatefulWidget {
  const AddDataReserva({super.key});

  @override
  State<AddDataReserva> createState() => _AddDataReservaState();
}

class _AddDataReservaState extends State<AddDataReserva> {
  TextEditingController controllerNumeroHabitacion = TextEditingController();
  TextEditingController controllerFechaIngreso = TextEditingController();
  TextEditingController controllerFechaSalida = TextEditingController();
  TextEditingController controllerServicio = TextEditingController();
  TextEditingController controllerCliente = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void addData() {
    var url = Uri.parse(
        'http://10.170.83.33/bd_funhotel_flutter/adddataReservas.php');

    http.post(url, body: {
      'idHabitacion': controllerNumeroHabitacion.text,
      'idCliente': controllerCliente.text,
      'idServicio': controllerServicio.text,
      'fecIngreso': controllerFechaIngreso.text,
      'fecSalida': controllerFechaSalida.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: TextFormField(
                  controller: controllerNumeroHabitacion,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingresa el numero de habitacion";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Numero de habitacion",
                      hintText: "Numero de habitacion"),
                ),
              ),
              // cliente, servicio, fecha ingreso, fecha salida
              ListTile(
                title: TextFormField(
                  controller: controllerCliente,
                  validator: (value) {
                    if (value!.isEmpty) return "Ingresa el id del cliente";
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Id del cliente", hintText: "Id del cliente"),
                ),
              ),
              ListTile(
                title: TextFormField(
                  controller: controllerServicio,
                  validator: (value) {
                    if (value!.isEmpty) return "Ingresa el id del servicio";
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Id del servicio",
                      hintText: "Id del servicio"),
                ),
              ),
              ListTile(
                title: TextFormField(
                  controller: controllerFechaIngreso,
                  validator: (value) {
                    if (value!.isEmpty) return "Ingresa la fecha de ingreso";
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Fecha de ingreso",
                      hintText: "Fecha de ingreso"),
                ),
              ),
              ListTile(
                title: TextFormField(
                  controller: controllerFechaSalida,
                  validator: (value) {
                    if (value!.isEmpty) return "Ingresa la fecha de salida";
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Fecha de salida",
                      hintText: "Fecha de salida"),
                ),
              ),
              // boton
              Padding(
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addData();
                      Navigator.pushReplacementNamed(context, '/listarReserva');
                    }
                  },
                  child: Text("Agregar"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
