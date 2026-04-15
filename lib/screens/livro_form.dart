import 'package:flutter/material.dart';
import 'package:proj_firebase/components/editor.dart';
import 'package:proj_firebase/model/livro.dart';
import 'package:proj_firebase/service/livro_dao.dart';

class LivroForm extends StatefulWidget {
  final Livro? livro;
  LivroForm({this.livro});
  @override
  State<StatefulWidget> createState() {
    return LivroFormState();
  }
}

class LivroFormState extends State<LivroForm> {
  final TextEditingController _controllerTitulo = TextEditingController();
  final TextEditingController _controllerDescricao = TextEditingController();
  final TextEditingController _controllerAutor = TextEditingController();
  final TextEditingController _controllerAvaliacao = TextEditingController();

  String? id;
  LivroDao _service = LivroDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livro', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gravar(context);
        },
        child: Icon(Icons.menu_book),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(_controllerTitulo, 'Titulo', 'Informe o titulo', null),
            Editor(
              _controllerDescricao,
              'Descrição',
              'Informe a descrição',
              null,
            ),
            Editor(_controllerAutor, 'Autor', 'Informe o autor', null),
            Editor(
              _controllerAvaliacao,
              'Avaliação',
              'Informe a avaliação',
              null,
            ),
          ],
        ),
      ),
    );
  }

  void gravar(BuildContext context) async {
    if (id != null) {
      final liv = Livro(
        autor: _controllerAutor.text,
        avaliacao: _controllerAutor.text,
        descricao: _controllerDescricao.text,
        id: id!,
        status: '0',
        titulo: _controllerTitulo.text,
      );
      await _service.update(liv).then((v) => Navigator.pop(context));
    } else {
      final liv = Livro(
        autor: _controllerAutor.text,
        avaliacao: _controllerAutor.text,
        descricao: _controllerDescricao.text,
        id: '',
        status: '0',
        titulo: _controllerTitulo.text,
      );
      await _service.add(liv).then((v) => Navigator.pop(context));
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Operação realizada com sucesso!')));
  }

  @override
  void initState() {
    super.initState();
    if (widget.livro != null) {
      id = widget.livro!.id;
      _controllerTitulo.text = widget.livro!.titulo;
      _controllerDescricao.text = widget.livro!.descricao;
      _controllerAutor.text = widget.livro!.autor;
      _controllerAvaliacao.text = widget.livro!.avaliacao;
    }
  }
}
