import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:z/pages/reservas/detail.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ListarReserva extends StatefulWidget {
  const ListarReserva({super.key});

  @override
  State<ListarReserva> createState() => _ListarReservaState();
}

class _ListarReservaState extends State<ListarReserva> {
  Future<List> getData() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.11/bd_funhotel_flutter/getdataReservas.php'),
    );
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Reservas'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 101, 76, 216),
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // ignore: avoid_print
            print(snapshot.error);
            return const Center(
              child: Text(
                'Error al cargar los datos',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          return snapshot.hasData
              ? ItemList(list: snapshot.data!)
              : const Center(
                  child: SpinKitDoubleBounce(
                    color: Color.fromARGB(255, 33, 173, 243),
                    size: 50.0,
                  ),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, i) {
        final numeroHabitacion = list[i]['numeroHabitacion'] ?? 'No disponible';
        final nombreCliente = list[i]['primerNombre'] ?? 'No disponible';
        final nombreServicio = list[i]['nombre'] ?? 'No disponible';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => DetailReserva(
                  list: list,
                  index: i,
                ),
              ),
            ),
            child: Card(
              elevation: 22,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                title: Text(
                  'Habitación: $numeroHabitacion',
                  style: const TextStyle(
                      fontSize: 18, color: Color.fromARGB(255, 8, 8, 8)),
                ),
                leading: const Icon(
                  Icons.calendar_today,
                  size: 30,
                  color: Color.fromARGB(255, 49, 18, 205),
                ),
                subtitle: Text(
                  'Cliente: $nombreCliente',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                trailing: Text(
                  '$nombreServicio',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
