import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registro/auth_controller.dart';
import 'package:registro/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: w,
              height: h*0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/logoHD.png"),
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
                    "Bienvenido",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Inicia sesión con tu cuenta",
                    style: TextStyle(
                      fontSize: 20,
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
                    //Campo para ingresar el usuario
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
                    //Campo para ingresar la contraseña
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
                  Row(
                    children: [
                      Expanded(child: Container(),),
                      const Text(
                        "¿Olvidaste tu contraseña?",
                        style: TextStyle(
                        fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60,),
            GestureDetector(
              onTap: () {
                AuthController.instance.login(emailController.text.trim(), passwordController.text.trim());
               
              },
              child: Container(
                width: w*0.5,
                height: h*0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: const DecorationImage(
                    image: AssetImage("images/boton.png"),
                    fit: BoxFit.cover
                  )
                ),
                child:const Center (
                  child: Text(
                    "Ingresar",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: w*0.1,),
            RichText(text: TextSpan(
              text: "¿No tienes cuenta?",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 20,
              ),
              children: [
                TextSpan(
                  text: " Crear cuenta",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage())
                )
              ]
            ))
          ],
        ),
      ),
    );
  }
}