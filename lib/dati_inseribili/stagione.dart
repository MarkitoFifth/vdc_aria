import 'dati.dart';

class Stagione {
  final int? id;
  final String nome;
  final List<Partita> partite;

  Stagione({
    this.id,
    required this.nome,
    List<Partita>? partite,
  }) : partite = partite ?? [];
}