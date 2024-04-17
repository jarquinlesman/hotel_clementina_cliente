import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registro/login_page.dart';
import 'package:registro/pantallas/inicio.dart';

class AuthController extends GetxController{
  //AuthController.instance...
  static AuthController instance = Get.find();
  
  //correo, contraseña, nombre
  late Rx<User?> _user;
  
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //Al usuario no se le notifica del seguimiento
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);

  }

  _initialScreen(User? user) {
    //Verificar si el usuario ya inició sesión
    if(user==null){
      Get.offAll(()=>LoginPage());
    }else {
      // Obtener el correo electrónico del usuario actualmente autenticado
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
      Get.offAll(()=>Inicio(userEmail: userEmail ?? '',));
    }
  }

  void register(String email, password)async{
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    }catch(e) {
      Get.snackbar("Acerca del usuario", "Mensaje del usuario",
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Lo sentimos, no se pudo crear su cuenta.",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            color: Colors.white
          ),
        ));
    }
    
  }

  void login(String email, password)async{
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e) {
      Get.snackbar("Acerca del inicio de sesión", "Mensaje del Inicio de Sesión",
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Lo sentimos, ocurrió un error al momento de iniciar sesión.",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            color: Colors.white
          ),
        ));
    }
  }

  void logOut() {
    auth.signOut();
  }
}