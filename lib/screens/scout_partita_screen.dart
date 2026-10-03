import 'package:flutter/material.dart';

import '../dati_inseribili/dati.dart';
import '../services/archivio_stagioni.dart';

class ScoutPartitaScreen extends StatefulWidget {
  final String avversario;
  final String categoria;
  final String risultato;
  final String luogo;
  final DateTime data;

  const ScoutPartitaScreen({
    super.key,
    required this.avversario,
    required this.categoria,
    required this.risultato,
    required this.luogo,
    required this.data,
  });

  @override
  State<ScoutPartitaScreen> createState() =>
      _ScoutPartitaScreenState();
}

class _ScoutPartitaScreenState
    extends State<ScoutPartitaScreen> {

  // =========================
  // ATTACCO
  // =========================

  final TextEditingController attacchiEffettuati =
      TextEditingController();

  final TextEditingController attacchiPunto =
      TextEditingController();

  final TextEditingController attacchiErrori =
      TextEditingController();

  final TextEditingController attacchiMurati =
      TextEditingController();

  // =========================
  // BATTUTA
  // =========================

  final TextEditingController battuteEffettuate =
      TextEditingController();

  final TextEditingController battutePunto =
      TextEditingController();

  final TextEditingController battuteErrori =
      TextEditingController();

  // =========================
  // RICEZIONE
  // =========================

  final TextEditingController ricezioniEffettuate =
      TextEditingController();

  final TextEditingController ricezioniPositive =
      TextEditingController();

  final TextEditingController ricezioniNegative =
      TextEditingController();

  final TextEditingController ricezioniErrori =
      TextEditingController();

  // =========================
  // MURO
  // =========================

  final TextEditingController muriEffettuati =
      TextEditingController();

  final TextEditingController muriPunto =
      TextEditingController();

  final TextEditingController muriErrori =
      TextEditingController();

  // =========================
  // DIFESA
  // =========================

  final TextEditingController difeseEffettuate =
      TextEditingController();

  final TextEditingController difesePositive =
      TextEditingController();

  final TextEditingController difeseNegative =
      TextEditingController();

  final TextEditingController difeseErrori =
      TextEditingController();

  // =========================
  // CONVERSIONE VALORI
  // =========================

  int valore(
    TextEditingController controller,
  ) {
    return int.tryParse(
          controller.text.trim(),
        ) ??
        0;
  }

  // =========================
  // SALVATAGGIO PARTITA
  // =========================

  Future<void> salvaPartita() async {
    final Partita nuovaPartita = Partita(
      avversario: widget.avversario,
      categoria: widget.categoria,
      risultato: widget.risultato,
      luogo: widget.luogo,
      data: widget.data,

      // =========================
      // ATTACCO
      // =========================

      attacchi: DatiAttacchi(
        attacchiEffettuati:
            valore(attacchiEffettuati),

        attacchiPunto:
            valore(attacchiPunto),

        attacchiErrori:
            valore(attacchiErrori),

        attacchiMurati:
            valore(attacchiMurati),
      ),

      // =========================
      // BATTUTA
      // =========================

      battuta: DatiBattuta(
        battuteEffettuate:
            valore(battuteEffettuate),

        battutePunto:
            valore(battutePunto),

        battuteErrori:
            valore(battuteErrori),
      ),

      // =========================
      // RICEZIONE
      // =========================

      ricezione: DatiRicezione(
        ricezioniEffettuate:
            valore(ricezioniEffettuate),

        ricezioniPositive:
            valore(ricezioniPositive),

        ricezioniNegative:
            valore(ricezioniNegative),

        ricezioniErrori:
            valore(ricezioniErrori),
      ),

      // =========================
      // MURO
      // =========================

      muro: DatiMuro(
        muriEffettuati:
            valore(muriEffettuati),

        muriPunto:
            valore(muriPunto),

        muriErrori:
            valore(muriErrori),
      ),

      // =========================
      // DIFESA
      // =========================

      difesa: DatiDifesa(
        difeseEffettuate:
            valore(difeseEffettuate),

        difesePositive:
            valore(difesePositive),

        difeseNegative:
            valore(difeseNegative),

        difeseErrore:
            valore(difeseErrori),
      ),
    );

    // =========================
    // SALVA SU SQLITE
    // =========================

    await ArchivioStagioni.aggiungiPartita(
      nuovaPartita,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Partita salvata!',
        ),
      ),
    );

    // Torna alla Home
    Navigator.pop(context);
    Navigator.pop(context);
  }

  // =========================
  // CAMPO NUMERICO
  // =========================

  Widget campoNumerico(
    String titolo,
    TextEditingController controller,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 12),

      child: TextField(
        controller: controller,

        keyboardType:
            TextInputType.number,

        decoration: InputDecoration(
          labelText: titolo,
          border:
              const OutlineInputBorder(),
        ),
      ),
    );
  }

  // =========================
  // TITOLO SEZIONE
  // =========================

  Widget titoloSezione(
    String testo,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        top: 25,
        bottom: 15,
      ),

      child: Text(
        testo,

        style: const TextStyle(
          fontSize: 22,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }

  // =========================
  // DISPOSE
  // =========================

  @override
  void dispose() {
    attacchiEffettuati.dispose();
    attacchiPunto.dispose();
    attacchiErrori.dispose();
    attacchiMurati.dispose();

    battuteEffettuate.dispose();
    battutePunto.dispose();
    battuteErrori.dispose();

    ricezioniEffettuate.dispose();
    ricezioniPositive.dispose();
    ricezioniNegative.dispose();
    ricezioniErrori.dispose();

    muriEffettuati.dispose();
    muriPunto.dispose();
    muriErrori.dispose();

    difeseEffettuate.dispose();
    difesePositive.dispose();
    difeseNegative.dispose();
    difeseErrori.dispose();

    super.dispose();
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scout partita',
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // =========================
            // INFORMAZIONI PARTITA
            // =========================

            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      'VS ${widget.avversario}',
                      style:
                          const TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      '${widget.categoria} • '
                      '${widget.luogo}',
                    ),

                    const SizedBox(
                      height: 4,
                    ),

                    Text(
                      'Risultato: ${widget.risultato}',
                    ),

                    const SizedBox(
                      height: 4,
                    ),

                    Text(
                      'Data: '
                      '${widget.data.day.toString().padLeft(2, '0')}/'
                      '${widget.data.month.toString().padLeft(2, '0')}/'
                      '${widget.data.year}',
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      'Stagione: '
                      '${ArchivioStagioni.stagioneAttiva.nome}',
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =========================
            // ATTACCO
            // =========================

            titoloSezione(
              'ATTACCO',
            ),

            campoNumerico(
              'Attacchi effettuati',
              attacchiEffettuati,
            ),

            campoNumerico(
              'Attacchi punto',
              attacchiPunto,
            ),

            campoNumerico(
              'Attacchi errore',
              attacchiErrori,
            ),

            campoNumerico(
              'Attacchi murati',
              attacchiMurati,
            ),

            // =========================
            // BATTUTA
            // =========================

            titoloSezione(
              'BATTUTA',
            ),

            campoNumerico(
              'Battute effettuate',
              battuteEffettuate,
            ),

            campoNumerico(
              'Ace / battute punto',
              battutePunto,
            ),

            campoNumerico(
              'Battute errore',
              battuteErrori,
            ),

            // =========================
            // RICEZIONE
            // =========================

            titoloSezione(
              'RICEZIONE',
            ),

            campoNumerico(
              'Ricezioni effettuate',
              ricezioniEffettuate,
            ),

            campoNumerico(
              'Ricezioni positive',
              ricezioniPositive,
            ),

            campoNumerico(
              'Ricezioni negative',
              ricezioniNegative,
            ),

            campoNumerico(
              'Ricezioni errore',
              ricezioniErrori,
            ),

            // =========================
            // MURO
            // =========================

            titoloSezione(
              'MURO',
            ),

            campoNumerico(
              'Muri effettuati',
              muriEffettuati,
            ),

            campoNumerico(
              'Muri punto',
              muriPunto,
            ),

            campoNumerico(
              'Muri errore',
              muriErrori,
            ),

            // =========================
            // DIFESA
            // =========================

            titoloSezione(
              'DIFESA',
            ),

            campoNumerico(
              'Difese effettuate',
              difeseEffettuate,
            ),

            campoNumerico(
              'Difese positive',
              difesePositive,
            ),

            campoNumerico(
              'Difese negative',
              difeseNegative,
            ),

            campoNumerico(
              'Difese errore',
              difeseErrori,
            ),

            const SizedBox(
              height: 20,
            ),

            // =========================
            // SALVA
            // =========================

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed:
                    salvaPartita,

                style:
                    ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                ),

                child: const Text(
                  'SALVA PARTITA',
                  style:
                      TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}