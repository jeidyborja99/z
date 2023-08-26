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
      Uri.parse('http://192.168.1.54/bd_funhotel_flutter/getdataReservas.php'),
    );
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Reservas'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text(
                'Error al cargar los datos',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          return snapshot.hasData
              ? ItemList(list: snapshot.data!)
              : Center(
                  child: SpinKitDoubleBounce(
                    color: Colors.blue,
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
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                title: Text(
                  'Habitación: $numeroHabitacion',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
                leading: Icon(
                  Icons.calendar_today,
                  size: 30,
                  color: Colors.blue,
                ),
                subtitle: Text(
                  'Cliente: $nombreCliente',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                trailing: Text(
                  '$nombreServicio',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
