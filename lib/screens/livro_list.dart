import 'package:flutter/material.dart';
import 'package:proj_firebase/model/livro.dart';
import 'package:proj_firebase/screens/livro_form.dart';
import 'package:proj_firebase/service/livro_dao.dart';
import 'package:get/get.dart';

class LivroController extends GetxController {
  //essa classe define as variaveis de controle e os metodos que estariam no setState

  final LivroDao _service = LivroDao();
  var livros = <Livro>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLivros();
  }

  Future<void> fetchLivros() async {
    try {
      final lista = await _service.getList();
      livros.value = lista;
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao carregar os dados');
    }
  }

  Future<void> excluir(String id) async {
    await _service.delete(id);
    fetchLivros();
  }
}

class LivroList extends StatelessWidget {
  LivroList({Key? key}) : super(key: key);

  final LivroController controller = Get.put(LivroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text('Meus Livros', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () async {
          await Get.to(() => LivroForm());
          controller.fetchLivros();
        },
        child: Icon(Icons.menu_book, color: Colors.white),
      ),

      body: Obx(() {
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
            return itemLivro(context, item);
          },
        );
      }),
    );
  }

  Widget itemLivro(BuildContext context, Livro livro) {
    return GestureDetector(
      onTap: () async {
        await Get.to(() => LivroForm(livro: livro));
        controller.fetchLivros();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),

            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple.shade100,
              child: Icon(Icons.book, color: Colors.deepPurple),
            ),

            title: Text(
              livro.titulo,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            subtitle: Text(
              livro.autor,
              style: TextStyle(color: Colors.grey[600]),
            ),

            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => _excluir(context, livro.id),
            ),
          ),
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
