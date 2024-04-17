import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationDialog extends StatefulWidget {
  final String clientName;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String roomId;

  ReservationDialog({
    required this.clientName,
    required this.checkInDate,
    required this.checkOutDate,
    required this.roomId,
  });

  @override
  _ReservationDialogState createState() => _ReservationDialogState();
}

class _ReservationDialogState extends State<ReservationDialog> {
  late TextEditingController _clientNameController;
  late DateTime _selectedCheckInDate;
  late DateTime _selectedCheckOutDate;
  double _roomPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _clientNameController = TextEditingController(text: widget.clientName);
    _selectedCheckInDate = widget.checkInDate;
    _selectedCheckOutDate = widget.checkOutDate;
    _fetchRoomPrice();
  }

  @override
  void dispose() {
    _clientNameController.dispose();
    super.dispose();
  }

  Future<void> _fetchRoomPrice() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> roomSnapshot =
          await FirebaseFirestore.instance
              .collection('habitaciones')
              .doc(widget.roomId)
              .get();
      if (roomSnapshot.exists) {
        setState(() {
          _roomPrice = roomSnapshot.data()!['precio'].toDouble();
        });
      }
    } catch (e) {
      print('Error al obtener el precio de la habitación: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    int numberOfDays =
        _selectedCheckOutDate.difference(_selectedCheckInDate).inDays;
    double totalPrice = numberOfDays * _roomPrice;

    return AlertDialog(
      title: Text('Detalles de la reserva'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _clientNameController,
            decoration: InputDecoration(labelText: 'Nombre del cliente'),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text('Fecha de entrada:'),
                  subtitle: Text(_formatDate(_selectedCheckInDate)),
                  onTap: () => _selectCheckInDate(context),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text('Fecha de salida:'),
                  subtitle: Text(_formatDate(_selectedCheckOutDate)),
                  onTap: () => _selectCheckOutDate(context),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text('Total: \$${totalPrice.toStringAsFixed(2)}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cerrar el diálogo
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            // Realizar la reserva con los datos actualizados
            Navigator.of(context).pop();
          },
          child: Text('Reservar'),
        ),
      ],
    );
  }

  Future<void> _selectCheckInDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedCheckInDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedCheckInDate) {
      setState(() {
        _selectedCheckInDate = pickedDate;
      });
    }
  }

  Future<void> _selectCheckOutDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedCheckOutDate,
      firstDate: _selectedCheckInDate,
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedCheckOutDate) {
      setState(() {
        _selectedCheckOutDate = pickedDate;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class Reservar extends StatefulWidget {
  @override
  _Reservar createState() => _Reservar();
}

class _Reservar extends State<Reservar> {
  String? _habitacion;
  double? _precioHabitacion;
  String? _habitacionId;

  @override
  void initState() {
    super.initState();
    _fetchDataFromFirestore();
  }

   Future<void> _fetchDataFromFirestore() async {
  try {
    // Realizar una consulta a Firestore para obtener el ID de la habitación basado en la categoría
    QuerySnapshot<Map<String, dynamic>> habitacionSnapshot = await FirebaseFirestore.instance
        .collection('habitaciones')
        .where('categoria', isEqualTo: 'nombre de la categoria') // Reemplaza 'nombre de la categoria' con la categoría deseada
        .limit(1) // Limita la consulta a un único documento
        .get();

    // Comprueba si se encontró un documento
    if (habitacionSnapshot.docs.isNotEmpty) {
      // Obtiene el ID del documento encontrado
      String habitacionId = habitacionSnapshot.docs.first.id;
      setState(() {
        _habitacionId = habitacionId;
      });
    } else {
      print('No se encontró ninguna habitación con la categoría especificada.');
    }
  } catch (e) {
    print('Error al obtener datos desde Firestore: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 114, 128, 235),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'images/logoHD.png',
              height: 40,
              width: 40,
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Reservar',
                  style: TextStyle(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.3), // Color y opacidad de la sombra
                    spreadRadius: 2, // Extensión de la sombra
                    blurRadius: 5, // Difuminado de la sombra
                    offset: Offset(0, 2), // Desplazamiento de la sombra
                  ),
                ],
                border: Border.all(
                  color: Colors.grey, // Color del contorno
                  width: 2, // Grosor del contorno
                ),
                image: DecorationImage(
                  image: AssetImage('images/hotel1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: const Text(
                      'Descripción de la habitación',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(54, 146, 210, 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    width: double.infinity, // Ancho completo
                    child: Divider(), // Divisor después del texto
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${_habitacion ?? 'Cargando...'}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Incluye:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Color.fromRGBO(167, 167, 167, 1),
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.check_circle, // Icono de confirmación
                        color: Colors.green, // Color del icono
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              'Aire acondicionado ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Color.fromRGBO(167, 167, 167, 1),
                              ),
                            ),
                            Icon(
                              Icons.ac_unit, // Ejemplo de icono
                              color: Colors.grey,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.check_circle, // Icono de confirmación
                        color: Colors.green, // Color del icono
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              'Desayuno incluido ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Color.fromRGBO(167, 167, 167, 1),
                              ),
                            ),
                            Icon(
                              Icons.free_breakfast, // Ejemplo de icono
                              color: Colors.grey,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.check_circle, // Icono de confirmación
                        color: Colors.green, // Color del icono
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              'Parqueo gratis ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Color.fromRGBO(167, 167, 167, 1),
                              ),
                            ),
                            Icon(
                              Icons.local_parking, // Ejemplo de icono
                              color: Colors.grey,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.check_circle, // Icono de confirmación
                        color: Colors.green, // Color del icono
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              'Baño privado ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Color.fromRGBO(167, 167, 167, 1),
                              ),
                            ),
                            Icon(
                              Icons.bathtub, // Ejemplo de icono
                              color: Colors.grey,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.check_circle, // Icono de confirmación
                        color: Colors.green, // Color del icono
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              'Wi-Fi gratis ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Color.fromRGBO(167, 167, 167, 1),
                              ),
                            ),
                            Icon(
                              Icons.wifi, // Ejemplo de icono
                              color: Colors.grey,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Precio: L. ${_precioHabitacion != null ? '\$${_precioHabitacion!.toStringAsFixed(2)}' : 'Cargando...'}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        _showReservationDialog();
                      },
                      child: Text(
                        'Reservar',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(54, 146, 210, 1),
                        elevation: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReservationDialog() {
    if (_habitacionId != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ReservationDialog(
            clientName: 'Nombre del cliente',
            checkInDate: DateTime.now(),
            checkOutDate: DateTime.now().add(Duration(days: 3)),
            roomId: _habitacionId!,
          );
        },
      );
    } else {
      print('No se pudo encontrar el ID de la habitación.');
    }
  }
}