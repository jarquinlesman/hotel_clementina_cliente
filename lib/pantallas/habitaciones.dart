import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Importa el paquete de CarouselSlider
import 'package:registro/reservar/reservar.dart'; 

class Categoria extends StatefulWidget {
  const Categoria({Key? key}) : super(key: key);

  @override
  _CategoriaState createState() => _CategoriaState();
}

class _CategoriaState extends State<Categoria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: 12,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                buildContainer(
                  imageUrls: [
                    'images/sencilla1.jpg',
                    'images/sencilla2 (2).jpg',
                    'images/sencilla2.jpg',
                    'images/b1.jpg',
                  ],
                  title: 'Sencilla',
                  price: 'HNL 1300',
                ),
                buildContainer(
                  imageUrls: [
                    'images/pareja1.jpg',
                    'images/pareja3.jpg',
                    'images/pareja4.jpg',
                    'images/pareja22.jpg',
                    'images/bp11.jpg',
                  ],
                  title: 'Pareja',
                  price: 'HNL 1700',
                ),
                buildContainer(
                  imageUrls: [
                    'images/d2.jpg',
                    'images/d4.jpg',
                    'images/d5.jpg',
                  ],
                  title: 'Doble',
                  price: 'HNL 1850',
                ),
                buildContainer(
                  imageUrls: [
                    'images/t1.jpg',
                    'images/t2.jpg',
                    'images/t3.jpg',
                    'images/t4.jpg',
                    'images/t33.jpg',
                    'images/b1.jpg',
                  ],
                  title: 'Triple',
                  price: 'HNL 2650',
                ),
                buildContainer(
                  imageUrls: [
                    'images/suit1p1.jpg',
                    'images/suit1p2.jpg',
                    'images/b1.jpg',
                  ],
                  title: 'Suite Junior (1 Persona)',
                  price: 'HNL 1450',
                ),
                buildContainer(
                  imageUrls: [
                    'images/suit2p1.jpg',
                    'images/suit2p11.jpg',
                    'images/suit2p3.jpg',
                    'images/b1.jpg',
                  ],
                  title: 'Suite Junior (2 Personas)',
                  price: 'HNL 1800',
                ),
                buildContainer(
                  imageUrls: [
                    'images/p2.jpg',
                    'images/p3.jpg',
                    'images/p4.jpg',
                    'images/p22.jpg',
                    'images/b1.jpg',
                  ],
                  title: 'Suite Principal',
                  price: 'HNL 2100',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContainer(
      {required List<String> imageUrls,
      required String title,
      required String price}) {
    return Container(
      width: 380,
      height: 458,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.blue.shade100, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5, //Lo extenso de la sombra
            blurRadius: 9, //La opacidad extendida
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 0,
          ),
          CarouselSlider(
            items: imageUrls.map((imageUrl) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 260, //Tamaño del carrusel
              viewportFraction: 1,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: 350,
            height: 33,
            // Ocupa todo el espacio horizontal disponible
            child: Text(
              title,
              textAlign: TextAlign.left, // Alinea el texto a la izquierda
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            // Línea divisora
            //#E6B800
            color: Color(0xFFE6B800),
            thickness: 2, //grosor de la linea en pixeles
            height:
                20, //Define la altura vertical de la línea divisora en píxeles
            indent: 10, //Define el espacio a la izquierda de la línea divisora
            endIndent: 10, //Define el espacio a la derecha de la línea divisora
          ),
          Container(
            width: 350,
            height: 40,
            // Ocupa todo el espacio horizontal disponible
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.paid_outlined, // Icono de dinero
                  color: Colors.green, // Color del icono
                  size: 30.0, // Tamaño del icono
                ),
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 350,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              border: Border.all(
                  color: const Color.fromARGB(255, 254, 255, 255),
                  width: 0), //borde del container
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 147, 153, 155).withOpacity(0.3),
                  spreadRadius: 3, //Lo extenso de la sombra
                  blurRadius: 7, //La opacidad extendida
                  offset: Offset(0, 5), //Desplazamiento del eje XY
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Reservar()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFFE6B800)), // Cambia el color de fondo a amarillo
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        80.0), // Ajusta el radio para hacer los bordes redondos
                  ),
                ),
              ),
              child: Text(
                'Reservar',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}