import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:registro/auth_controller.dart';
import 'package:registro/login_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    //Imágenes para las redes sociales
    List images = [
      "google.png",
      "X.png",
      "facebook.png",
    ];

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView( // Agrega SingleChildScrollView aquí
        child: Column(
          children: [
            Container(
              width: w,
              height: h*0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/logoHD.png"
                  ),
                  fit: BoxFit.contain
                )
              )
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Registrarse",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: const Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        )
                      ]
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Correo electrónico",
                        prefixIcon: const Icon(Icons.email),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: const Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        )
                      ]
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Contraseña",
                        prefixIcon: const Icon(Icons.password),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  /*Row(
                    children: [
                      Expanded(child: Container(),),
                      const Text(
                        "¿Olvidaste tu contraseña?",
                        style: TextStyle(
                        fontSize: 20,
                        ),
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
            const SizedBox(height: 40,),
            GestureDetector(
              onTap: () {
                AuthController.instance.register(emailController.text.trim(), passwordController.text.trim());
              },
              child: Container(
                width: w*0.5,
                height: h*0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: const DecorationImage(
                    image: AssetImage(
                      "images/boton.png"
                    ),
                    fit: BoxFit.cover
                  )
                ),
                child:const Center (
                  child: Text(
                    "Registrarse",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () {
                  Get.offAll(LoginPage());
                },
                text: "¿Ya tienes una cuenta?",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[500]
                )
              )
            ),
            SizedBox(height: w*0.1,),
            RichText(text: TextSpan(
              text: "Registrate usando los siguientes métodos",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
              ),
            )),
            Wrap(
              children: List<Widget>.generate(
                3,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color.fromARGB(230, 230, 184, 0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                          "images/"+images[index]
                        ),
                      ),
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}