// ignore_for_file: unused_import, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Reservaciones extends StatefulWidget {
  final String userEmail;

  const Reservaciones({Key? key, required this.userEmail}) : super(key: key);

  @override
  _ReservacionesState createState() => _ReservacionesState();
}

class _ReservacionesState extends State<Reservaciones> {
  late Stream<QuerySnapshot> reservasStream;

  @override
  void initState() {
    super.initState();
    reservasStream = FirebaseFirestore.instance
        .collection('reservaciones')
        .where('correo', isEqualTo: widget.userEmail)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tus Reservaciones',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: StreamBuilder(
                stream: reservasStream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text('No hay reservaciones para este usuario.'),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var reserva = snapshot.data!.docs[index];
                      return _buildReservaCard(reserva);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReservaCard(DocumentSnapshot reserva) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cliente: ${reserva['cliente']}'),
            Text('Habitación: ${reserva['habitacion']}'),
            Text('Precio Habitación: ${reserva['precio_habitacion']}'),
            Text('Fecha Llegada: ${reserva['fecha_llegada']}'),
            Text('Fecha Salida: ${reserva['fecha_salida']}'),
            Text('Observación: ${reserva['observacion']}'),
          ],
        ),
      ),
    );
  }
}