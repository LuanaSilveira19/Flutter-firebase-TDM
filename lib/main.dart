import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:proj_firebase/screens/livro_list.dart';

/*GetX
É uma biblioteca que combina gerenciador de estado de alta performace,
injeção de de dependência inteligente e gerenciamento de rotas de uma
forma rápida e pratica.

3 princípios básicos:
PERFORMACE: focado em desempenho e consumo mínimo de recurso
PRODUTIVIDADE: sintáxe fácil e amigável
ORGANIZAÇÃO: permite desaclopamento total da view, lógica de apresentação, 
lógica de negócios, injeção de dependência e navegação

https://youtu.be/BxCnSmLJojE?si=6qztXbkXG-CX7JHt

flutter pub add get

import 'package:get/get.dart'; 

Arquivo livro_list.dart com o metodo

*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Livros',
      debugShowCheckedModeBanner: false,
      home: LivroList(),
    );
  }
}
