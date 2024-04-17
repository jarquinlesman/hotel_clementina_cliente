// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, deprecated_member_use
import 'package:get/get.dart';
import 'package:registro/auth_controller.dart';
import 'package:registro/login_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:registro/pantallas/habitaciones.dart';
import 'package:registro/pantallas/reservaciones.dart';


class Inicio extends StatefulWidget {
  final String userEmail;
  const Inicio({Key? key, required this.userEmail}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 114, 128, 235),
        leading: Image.asset(
          'images/logoHD.png',
          height: 40,
          width: 40,
        ),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              AuthController.instance.logOut();
               Get.offAll(() => LoginPage());
            },
          icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bienvenido a Hotel Clementina',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'Tu Lugar de Destino',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 10.0),
                if (_selectedIndex == 0) // Mostrar el carrusel solo si está seleccionada la pantalla de inicio
                  content(),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Container(
                    color: Color.fromARGB(255, 255, 204, 0), // Color de fondo del TabBar
                    child: TabBar(
                      indicatorColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.white,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                      tabs: const [
                        Tab(
                          child: Text(
                            "Inicio",
                            style: TextStyle(fontSize: 18), 
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Habitaciones",
                            style: TextStyle(fontSize: 18), 
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Reservaciones",
                            style: TextStyle(fontSize: 18), 
                          ),
                        ),
                      ],
                      onTap: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    ),
                  ),
                  Flexible(
                    child: IndexedStack(
                      index: _selectedIndex,
                      children: [
                        InicioHotel(), // Contenido relacionado con el hotel
                        Categoria(), // Pantalla de habitaciones
                        Reservaciones(userEmail: widget.userEmail,), // Pantalla de reservaciones
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget content() {
    return CarouselSlider(
      items: [
        'images/hotel1.jpg',
        'images/hotel2.jpg',
        'images/hotel3.jpeg',
        'images/hotel4.jpeg',
        'images/hoteln.jpg',
      ].map((String imagePath) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
      ),
    );
  }
}


class InicioHotel extends StatelessWidget {
  const InicioHotel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        children: [
          const Text(
            'Servicios del Hotel',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 26.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.ac_unit, color: Colors.black),
                  SizedBox(width: 5),
                  Text(
                    'Aire Acondicionado',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0, // Tamaño del texto
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Icon(Icons.tv, color: Colors.black),
                  SizedBox(width: 5),
                  Text(
                    'Smart TV de 43"',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0, // Tamaño del texto
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Icon(Icons.shower, color: Colors.black),
                  SizedBox(width: 5),
                  Text(
                    'Agua caliente',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0, // Tamaño del texto
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Icon(Icons.wifi, color: Colors.black),
                  SizedBox(width: 5),
                  Text(
                    'Wifi',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0, // Tamaño del texto
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Icon(Icons.local_parking, color: Colors.black),
                  SizedBox(width: 5),
                  Text(
                    'Amplio Parqueo',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0, // Tamaño del texto
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Icon(Icons.restaurant_menu, color: Colors.black),
                  SizedBox(width: 5),
                  Text(
                    'Desayuno por cortesía',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0, // Tamaño del texto
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Inicio2(),
          const Informacion(),
          const Redes(),
        ],
      ),
    );
  }
}

class Inicio2 extends StatelessWidget {
  const Inicio2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Clementina Eventos',
            style: TextStyle(
              color: Colors.black,
              fontSize: 26.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: 150,
            height: 150,
            child: Image.asset(
              'images/clementinaeven.png', // Ruta de la imagen dentro de la carpeta 'images'
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0), // Añade espacio a la derecha
                  child: Container(
                    alignment: Alignment.center, // Centra el contenido de la columna
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Bodas',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0, // Tamaño del texto
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '15 Años',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0, // Tamaño del texto
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Baby Shower',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0, // Tamaño del texto
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Cumpleaños',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0, // Tamaño del texto
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Eventos Corporativos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0, // Tamaño del texto
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Cumpleaños',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0, // Tamaño del texto
                          ),
                        ),
                        SizedBox(height: 30), // Espacio adicional
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0), // Añade espacio a la izquierda
                  child: Container(
                    alignment: Alignment.center, // Centra el contenido de la columna
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Eventos corporativos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0, // Tamaño del texto
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Graduaciones',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0, // Tamaño del texto
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Aniversarios',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0, // Tamaño del texto
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Pedida de Mano',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0, // Tamaño del texto
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Despedida de soltera',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0, // Tamaño del texto
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Servicios de Alimentación',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0, // Tamaño del texto
                          ),
                        ),
                        SizedBox(height: 15), // Espacio adicional
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Informacion extends StatelessWidget {
  const Informacion({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            'Visita nuestras páginas y',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'obtén toda la información',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'que necesitas.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          Container(
            height: 30,
            width: 250,
            margin: EdgeInsets.symmetric(vertical: 10), // Margen vertical
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 204, 0), // Color amarillo
              borderRadius: BorderRadius.circular(25), // Bordes semicirculares
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'hotelclementina@yahoo.com',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
        ],
      ), 
    );
  }
}

class Redes extends StatelessWidget {
  const Redes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _launchURL('https://www.facebook.com/profile.php?id=100069310840823'),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Image.asset(
              'images/logoface.png',
              width: 50,
              height: 50,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _launchURL('https://www.instagram.com/hotelclementina/'),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Image.asset(
              'images/logoig.png',
              width: 50,
              height: 50,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _launchURL('http://wa.me/50433842090'),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Image.asset(
              'images/logowhat.png',
              width: 50,
              height: 50,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Aquí puedes mostrar un mensaje de error al usuario si lo deseas
    }
  }
}
