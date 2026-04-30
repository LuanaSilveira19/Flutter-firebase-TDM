import 'package:cloud_firestore/cloud_firestore.dart';

class Livro {
  String id;
  String titulo;
  String descricao;
  String autor;
  String status;
  String avaliacao;
  Timestamp timestamp;

  Livro({
    required this.autor,
    required this.avaliacao,
    required this.descricao,
    required this.id,
    required this.status,
    required this.titulo,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'autor': autor,
      'status': status,
      'avaliacao': avaliacao,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }

  factory Livro.fromMap(Map<String, dynamic> map, String id) {
    return Livro(
      autor: map['autor'] as String,
      avaliacao: map['avaliacao'] as String,
      descricao: map['descricao'] as String,
      id: id,
      status: map['status'] as String,
      titulo: map['titulo'] as String,
      timestamp: map['timestamp'] != null
          ? map['timestamp'] as Timestamp
          : Timestamp.now(),
    );
  }
}
