import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailReserva extends StatefulWidget {
  final List list;
  final int index;
  const DetailReserva({super.key, required this.index, required this.list});

  @override
  State<DetailReserva> createState() => _DetailReservaState();
}

class _DetailReservaState extends State<DetailReserva> {
  void deleteData() {
    var url = Uri.parse(
        "http://192.168.1.11/bd_funhotel_flutter/deleteDataReserva.php");
    http.post(
      url,
      body: {
        'id': widget.list[widget.index]['id'].toString(),
      },
    ).then((response) {
      // ignore: avoid_print
      print(response.body);
    }).catchError((error) {
      // ignore: avoid_print
      print(error);
    });
  }

  // ignore: non_constant_identifier_names
  void Confirmar() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text(
        "¿Está seguro de eliminar este registro?",
        style: TextStyle(fontSize: 18),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            deleteData();
            Navigator.of(context).pushReplacementNamed('/listarReserva');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text("Si, eliminar"),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text("No"),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle de Reserva"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Detalle de Reserva",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            Text(
              "ID Reserva: ${widget.list[widget.index]['id']}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              "ID Habitación: ${widget.list[widget.index]['idHabitacion']}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              "Número de habitación: ${widget.list[widget.index]['numeroHabitacion']}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              "ID Servicio: ${widget.list[widget.index]['idServicio']}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              "Nombre de servicio: ${widget.list[widget.index]['nombre']}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              "ID Cliente: ${widget.list[widget.index]['idCliente']}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              "Nombre de cliente: ${widget.list[widget.index]['primerNombre']} ${widget.list[widget.index]['primerApellido']}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              "Fecha Ingreso: ${widget.list[widget.index]['fecIngreso']}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              "Fecha Salida: ${widget.list[widget.index]['fecSalida']}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.of(context).pushReplacement(
                //       MaterialPageRoute(
                //         builder: (BuildContext context) => const ListarReserva(),
                //       ),
                //     );
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.blueGrey,
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                //   ),
                //   child: const Text("Regresar"),
                // ),
                ElevatedButton(
                  onPressed: () {
                    Confirmar();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text("Eliminar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
