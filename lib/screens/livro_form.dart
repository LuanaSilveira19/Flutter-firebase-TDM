import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_firebase/components/editor.dart';
import 'package:proj_firebase/model/livro.dart';
import 'package:proj_firebase/service/livro_dao.dart';

class LivroForm extends StatefulWidget {
  final Livro? livro;

  const LivroForm({super.key, this.livro});

  @override
  State<LivroForm> createState() => _LivroFormState();
}

class _LivroFormState extends State<LivroForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerTitulo = TextEditingController();
  final TextEditingController _controllerDescricao = TextEditingController();
  final TextEditingController _controllerAutor = TextEditingController();
  final TextEditingController _controllerAvaliacao = TextEditingController();

  final LivroDao _service = LivroDao();

  String? id;

  static const tealPrincipal = Color(0xFF00897B);
  static const tealSuave = Color(0xFFB2DFDB);
  static const fundo = Color(0xFFF5F5F5);

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

  Future<void> gravar() async {
    try {
      if (id != null) {
        final liv = Livro(
          id: id!,
          titulo: _controllerTitulo.text,
          descricao: _controllerDescricao.text,
          autor: _controllerAutor.text,
          avaliacao: _controllerAvaliacao.text,
          status: '0',
          timestamp: Timestamp.now(),
        );

        await _service.update(liv);
      } else {
        final liv = Livro(
          id: '',
          titulo: _controllerTitulo.text,
          descricao: _controllerDescricao.text,
          autor: _controllerAutor.text,
          avaliacao: _controllerAvaliacao.text,
          status: '0',
          timestamp: Timestamp.now(),
        );

        await _service.add(liv);
      }

      if (mounted) {
        Navigator.pop(context);
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Salvo com sucesso!')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao salvar: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,
      appBar: AppBar(
        title: Text(
          'Livros',
          style: GoogleFonts.lobsterTwo(fontSize: 28, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: tealPrincipal,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: tealPrincipal,
        child: const Icon(Icons.save, color: Colors.white),

        onPressed: () {
          if (_formKey.currentState!.validate()) {
            gravar();
          }
        },
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),

              Editor(
                _controllerTitulo,
                'Título',
                'Informe o título',
                Icons.book,
              ),

              Editor(
                _controllerDescricao,
                'Descrição',
                'Informe a descrição',
                Icons.description,
              ),

              Editor(
                _controllerAutor,
                'Autor',
                'Informe o autor',
                Icons.person,
              ),

              Editor(
                _controllerAvaliacao,
                'Avaliação',
                'Informe a avaliação',
                Icons.star,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
