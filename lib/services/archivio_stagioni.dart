import '../dati_inseribili/dati.dart';
import '../dati_inseribili/stagione.dart';
import 'database_service.dart';

class ArchivioStagioni {
  static final List<Stagione> stagioni = [];

  static int indiceStagioneAttiva = 0;

  static Stagione get stagioneAttiva {
    return stagioni[indiceStagioneAttiva];
  }

  // =========================
  // INIZIALIZZAZIONE
  // =========================

  static Future<void> inizializza() async {
    if (stagioni.isNotEmpty) {
      return;
    }

    final datiStagioni =
        await DatabaseService.leggiStagioni();

    for (final stagioneMap in datiStagioni) {
      final int stagioneId =
          stagioneMap['id'] as int;

      final partiteMap =
          await DatabaseService.leggiPartite(stagioneId);

      final List<Partita> partite =
          partiteMap
              .map(
                (map) =>
                    DatabaseService.partitaDaMap(map),
              )
              .toList();

      stagioni.add(
        Stagione(
          id: stagioneId,
          nome: stagioneMap['nome'] as String,
          partite: partite,
        ),
      );
    }

    // Se non esiste nessuna stagione,
    // ne creiamo automaticamente una.
    if (stagioni.isEmpty) {
      await creaStagione(
        '2026/27',
        seleziona: true,
      );
    }
  }

  // =========================
  // CAMBIA STAGIONE
  // =========================

  static void cambiaStagione(int indice) {
    if (indice < 0 ||
        indice >= stagioni.length) {
      return;
    }

    indiceStagioneAttiva = indice;
  }

  // =========================
  // CREA STAGIONE
  // =========================

  static Future<void> creaStagione(
    String nome, {
    bool seleziona = true,
  }) async {
    final nomePulito = nome.trim();

    if (nomePulito.isEmpty) {
      return;
    }

    final esiste = stagioni.any(
      (stagione) =>
          stagione.nome.toLowerCase() ==
          nomePulito.toLowerCase(),
    );

    if (esiste) {
      throw Exception(
        'Esiste già una stagione con questo nome.',
      );
    }

    final int id =
        await DatabaseService.inserisciStagione(
      nomePulito,
    );

    stagioni.add(
      Stagione(
        id: id,
        nome: nomePulito,
      ),
    );

    if (seleziona) {
      indiceStagioneAttiva =
          stagioni.length - 1;
    }
  }

  // =========================
  // AGGIUNGI PARTITA
  // =========================

  static Future<void> aggiungiPartita(
    Partita partita,
  ) async {
    final stagione = stagioneAttiva;

    if (stagione.id == null) {
      throw Exception(
        'La stagione attiva non ha un ID valido.',
      );
    }

    final int partitaId =
        await DatabaseService.inserisciPartita(
      stagione.id!,
      partita,
    );

    final Partita partitaSalvata =
        partita.copyWith(id: partitaId);

    stagione.partite.add(partitaSalvata);
  }

  // =========================
  // ELIMINA PARTITA
  // =========================

  static Future<void> eliminaPartita(
    Partita partita,
  ) async {
    if (partita.id == null) {
      return;
    }

    await DatabaseService.eliminaPartita(
      partita.id!,
    );

    stagioneAttiva.partite.removeWhere(
      (elemento) =>
          elemento.id == partita.id,
    );
  }

  // =========================
  // ELIMINA STAGIONE
  // =========================

  static Future<void> eliminaStagione(
    int indice,
  ) async {
    if (stagioni.length <= 1) {
      throw Exception(
        'Deve esistere almeno una stagione.',
      );
    }

    if (indice < 0 ||
        indice >= stagioni.length) {
      return;
    }

    final stagioneDaEliminare =
        stagioni[indice];

    if (stagioneDaEliminare.id != null) {
      await DatabaseService.eliminaStagione(
        stagioneDaEliminare.id!,
      );
    }

    stagioni.removeAt(indice);

    if (indiceStagioneAttiva >= stagioni.length) {
      indiceStagioneAttiva =
          stagioni.length - 1;
    } else if (indice < indiceStagioneAttiva) {
      indiceStagioneAttiva--;
    }
  }
}