import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/livro.dart';

class LivroDao {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> add(Livro livro) async {
    try {
      await _firestore.collection('livro').add(livro.toMap());
    } catch (e) {
      print('ERRO: $e');
    }
  }

  Future<void> update(Livro livro) async {
    try {
      final liv = _firestore.collection('livro').doc(livro.id);
      await liv.update(livro.toMap());
    } catch (e) {
      print('ERRO: $e');
    }
  }

  Future<void> delete(String id) async {
    try {
      final liv = _firestore.collection('livro').doc(id);
      await liv.delete();
    } catch (e) {
      print('ERRO: $e');
    }
  }

  Future<List<Livro>> getList() async {
    try {
      final snapshot = await _firestore.collection('livro').get();
      final lista = <Livro>[];
      for (var doc in snapshot.docs) {
        lista.add(Livro.fromMap(doc.data(), doc.id));
      }
      return lista;
    } catch (e) {
      print('ERRO REAL FIRESTORE: $e');
      rethrow;
    }
  }
}
