import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj_firebase/model/livro.dart';
import 'package:proj_firebase/model/user.dart';
import 'package:proj_firebase/screens/livro_form.dart';
import 'package:proj_firebase/service/livro_dao.dart';
import 'package:get/get.dart';
import 'package:proj_firebase/service/user_service.dart';

class LivroController extends GetxController {
  //essa classe define as variaveis de controle e os metodos que estariam no setState

  final LivroDao _service = LivroDao();
  var livros = <Livro>[].obs; //Lista relativa que atualiza UI automaticamente

  var currentUser = Rxn<UserModel>();
  var adm = false.obs;
  var expanded = <bool>[].obs;
  @override
  void onInit() {
    // Tipo o initState, ele roda quando o controller é criado

    super.onInit();
    fetchLivros();

    UserService _userService = UserService();

    if (FirebaseAuth.instance.currentUser != null) {
      _userService.getUser().then((userModel) {
        if (userModel != null) {
          currentUser.value = userModel;
          adm.value = true;
        }
      });
    }
  }

  Future<void> fetchLivros() async {
    try {
      final lista = await _service.getList();

      livros.assignAll(lista);

      expanded.assignAll(List.generate(lista.length, (_) => false));
      print("LIVROS: ${livros.length}");
      print("EXPANDED: ${expanded.length}");
    } catch (e) {
      print("ERRO FETCH: $e");
      Get.snackbar('Erro', 'Erro ao carregar os dados');
    }
  }

  Future<void> excluir(String id) async {
    await _service.delete(id);
    fetchLivros();
  }

  Future<void> alterar(Livro livro) async {
    await Get.to(() => LivroForm(livro: livro));
    await fetchLivros();
  }
}

class LivroList extends StatelessWidget {
  bool adm = false;
  UserModel? currentUser = null;

  LivroList({Key? key}) : super(key: key);

  final LivroController controller = Get.put(
    LivroController(),
  ); //cria e registra o controller -> parte da injeção de dependência

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: GetX<LivroController>(
        builder: (controller) {
          return controller.adm.value
              ? FloatingActionButton(
                  backgroundColor: Color(0xFF00897B),
                  onPressed: () async {
                    await Get.to(() => LivroForm());
                    await controller.fetchLivros();
                  },
                  child: Icon(Icons.menu_book, color: Colors.white),
                )
              : SizedBox.shrink();
        },
      ),
      body: Obx(() {
        //Obx detecta as mudanças e reconstroi automaticamente
        if (controller.livros.isEmpty) {
          return Center(
            child: Text(
              'Nenhum livro cadastrado',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: controller.livros.length,
          itemBuilder: (context, index) {
            final item = controller.livros[index];
            return itemLivro(context, item, index);
          },
        );
      }),
    );
  }

  Widget itemLivro(BuildContext context, Livro livro, int index) {
    return GestureDetector(
      onTap: () async {
        await Get.to(() => LivroForm(livro: livro));
        await controller.fetchLivros();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: Text(
                livro.titulo,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                livro.timestamp != null
                    ? 'Postado em ${DateFormat('dd/MM/yyyy HH:mm:ss').format(livro.timestamp.toDate())}'
                    : 'Data não disponível',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              trailing: controller.adm.value
                  ? IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => _excluir(context, livro.id),
                    )
                  : Padding(padding: EdgeInsets.zero),
              onTap: () async {
                if (controller.adm.value) {
                  await controller.alterar(livro);
                }
              },
            ),
            Obx(() {
              return controller.expanded[index]
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        livro.descricao,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    )
                  : SizedBox.shrink();
            }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
              ),
              onPressed: () {
                controller.expanded[index] = !controller.expanded[index];
                controller.expanded.refresh();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.expanded[index] ? "Esconder" : 'Expandir',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    controller.expanded[index]
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _excluir(BuildContext context, String id) {
    Get.defaultDialog(
      title: 'Excluir livro',
      middleText: 'Tem certeza que deseja excluir?',
      textCancel: 'Cancelar',
      textConfirm: 'Excluir',
      confirmTextColor: Colors.white,
      buttonColor: Colors.redAccent,
      onConfirm: () {
        controller.excluir(id);
        Get.back();
      },
    );
  }
}
