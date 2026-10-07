import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../dati_inseribili/dati.dart';

class DatabaseService {
  static Database? _database;

  static const int _versioneDatabase = 2;

  static Future<Database> get database async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(
      databasePath,
      'volley_data_center.db',
    );

    return await openDatabase(
      path,
      version: _versioneDatabase,

      onConfigure: (db) async {
        await db.execute(
          'PRAGMA foreign_keys = ON',
        );
      },

      onCreate: (db, version) async {
        await _creaTabelle(db);
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        await _creaTabelle(db);
      },
    );
  }

  static Future<void> _creaTabelle(
    Database db,
  ) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS stagioni (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL UNIQUE
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS partite (
        id INTEGER PRIMARY KEY AUTOINCREMENT,

        stagione_id INTEGER NOT NULL,

        avversario TEXT NOT NULL,
        categoria TEXT NOT NULL,
        risultato TEXT NOT NULL,
        luogo TEXT NOT NULL,
        data INTEGER NOT NULL,

        attacchi_effettuati INTEGER NOT NULL,
        attacchi_punto INTEGER NOT NULL,
        attacchi_errori INTEGER NOT NULL,
        attacchi_murati INTEGER NOT NULL,

        muri_effettuati INTEGER NOT NULL,
        muri_punto INTEGER NOT NULL,
        muri_errori INTEGER NOT NULL,

        battute_effettuate INTEGER NOT NULL,
        battute_punto INTEGER NOT NULL,
        battute_errori INTEGER NOT NULL,

        ricezioni_effettuate INTEGER NOT NULL,
        ricezioni_positive INTEGER NOT NULL,
        ricezioni_negative INTEGER NOT NULL,
        ricezioni_errori INTEGER NOT NULL,

        difese_effettuate INTEGER NOT NULL,
        difese_positive INTEGER NOT NULL,
        difese_negative INTEGER NOT NULL,
        difese_errori INTEGER NOT NULL,

        FOREIGN KEY (stagione_id)
          REFERENCES stagioni(id)
          ON DELETE CASCADE
      )
    ''');
  }

  // =========================================================
  // STAGIONI
  // =========================================================

  static Future<int> inserisciStagione(
    String nome,
  ) async {
    final db = await database;

    final nomePulito = nome.trim();

    if (nomePulito.isEmpty) {
      throw Exception(
        'Il nome della stagione non può essere vuoto.',
      );
    }

    try {
      return await db.insert(
        'stagioni',
        {
          'nome': nomePulito,
        },
        conflictAlgorithm:
            ConflictAlgorithm.abort,
      );
    } catch (e) {
      throw Exception(
        'Errore durante la creazione della stagione: $e',
      );
    }
  }

  static Future<List<Map<String, Object?>>> leggiStagioni() async {
    final db = await database;

    return await db.query(
      'stagioni',
      orderBy: 'id ASC',
    );
  }

  static Future<void> eliminaStagione(
    int stagioneId,
  ) async {
    final db = await database;

    await db.delete(
      'stagioni',
      where: 'id = ?',
      whereArgs: [stagioneId],
    );
  }

  // =========================================================
  // PARTITE
  // =========================================================

  static Future<int> inserisciPartita(
    int stagioneId,
    Partita partita,
  ) async {
    final db = await database;

    return await db.insert(
      'partite',
      {
        'stagione_id': stagioneId,

        'avversario': partita.avversario,
        'categoria': partita.categoria,
        'risultato': partita.risultato,
        'luogo': partita.luogo,
        'data': partita.data.millisecondsSinceEpoch,

        'attacchi_effettuati':
            partita.attacchi.attacchiEffettuati,
        'attacchi_punto':
            partita.attacchi.attacchiPunto,
        'attacchi_errori':
            partita.attacchi.attacchiErrori,
        'attacchi_murati':
            partita.attacchi.attacchiMurati,

        'muri_effettuati':
            partita.muro.muriEffettuati,
        'muri_punto':
            partita.muro.muriPunto,
        'muri_errori':
            partita.muro.muriErrori,

        'battute_effettuate':
            partita.battuta.battuteEffettuate,
        'battute_punto':
            partita.battuta.battutePunto,
        'battute_errori':
            partita.battuta.battuteErrori,

        'ricezioni_effettuate':
            partita.ricezione.ricezioniEffettuate,
        'ricezioni_positive':
            partita.ricezione.ricezioniPositive,
        'ricezioni_negative':
            partita.ricezione.ricezioniNegative,
        'ricezioni_errori':
            partita.ricezione.ricezioniErrori,

        'difese_effettuate':
            partita.difesa.difeseEffettuate,
        'difese_positive':
            partita.difesa.difesePositive,
        'difese_negative':
            partita.difesa.difeseNegative,
        'difese_errori':
            partita.difesa.difeseErrore,
      },
    );
  }

  static Future<List<Map<String, Object?>>> leggiPartite(
    int stagioneId,
  ) async {
    final db = await database;

    return await db.query(
      'partite',
      where: 'stagione_id = ?',
      whereArgs: [stagioneId],
      orderBy: 'data ASC',
    );
  }

  static Future<void> eliminaPartita(
    int partitaId,
  ) async {
    final db = await database;

    await db.delete(
      'partite',
      where: 'id = ?',
      whereArgs: [partitaId],
    );
  }

  // =========================================================
  // CONVERSIONE DATABASE → PARTITA
  // =========================================================

  static Partita partitaDaMap(
    Map<String, Object?> map,
  ) {
    return Partita(
      id: map['id'] as int,

      avversario:
          map['avversario'] as String,
      categoria:
          map['categoria'] as String,
      risultato:
          map['risultato'] as String,
      luogo:
          map['luogo'] as String,

      data:
          DateTime.fromMillisecondsSinceEpoch(
        map['data'] as int,
      ),

      attacchi: DatiAttacchi(
        attacchiEffettuati:
            map['attacchi_effettuati'] as int,
        attacchiPunto:
            map['attacchi_punto'] as int,
        attacchiErrori:
            map['attacchi_errori'] as int,
        attacchiMurati:
            map['attacchi_murati'] as int,
      ),

      muro: DatiMuro(
        muriEffettuati:
            map['muri_effettuati'] as int,
        muriPunto:
            map['muri_punto'] as int,
        muriErrori:
            map['muri_errori'] as int,
      ),

      battuta: DatiBattuta(
        battuteEffettuate:
            map['battute_effettuate'] as int,
        battutePunto:
            map['battute_punto'] as int,
        battuteErrori:
            map['battute_errori'] as int,
      ),

      ricezione: DatiRicezione(
        ricezioniEffettuate:
            map['ricezioni_effettuate'] as int,
        ricezioniPositive:
            map['ricezioni_positive'] as int,
        ricezioniNegative:
            map['ricezioni_negative'] as int,
        ricezioniErrori:
            map['ricezioni_errori'] as int,
      ),

      difesa: DatiDifesa(
        difeseEffettuate:
            map['difese_effettuate'] as int,
        difesePositive:
            map['difese_positive'] as int,
        difeseNegative:
            map['difese_negative'] as int,
        difeseErrore:
            map['difese_errori'] as int,
      ),
    );
  }
}