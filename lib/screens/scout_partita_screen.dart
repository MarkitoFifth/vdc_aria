import 'package:flutter/material.dart';

import '../dati_inseribili/dati.dart';
import '../services/archivio_partite.dart';

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
  final TextEditingController attacchiEffettuati =
      TextEditingController();
  final TextEditingController attacchiPunto =
      TextEditingController();
  final TextEditingController attacchiErrori =
      TextEditingController();
  final TextEditingController attacchiMurati =
      TextEditingController();

  final TextEditingController battuteEffettuate =
      TextEditingController();
  final TextEditingController battutePunto =
      TextEditingController();
  final TextEditingController battuteErrori =
      TextEditingController();

  final TextEditingController ricezioniEffettuate =
      TextEditingController();
  final TextEditingController ricezioniPositive =
      TextEditingController();
  final TextEditingController ricezioniNegative =
      TextEditingController();
  final TextEditingController ricezioniErrori =
      TextEditingController();

  final TextEditingController muriEffettuati =
      TextEditingController();
  final TextEditingController muriPunto =
      TextEditingController();
  final TextEditingController muriErrori =
      TextEditingController();

  final TextEditingController difeseEffettuate =
      TextEditingController();
  final TextEditingController difesePositive =
      TextEditingController();
  final TextEditingController difeseNegative =
      TextEditingController();
  final TextEditingController difeseErrori =
      TextEditingController();

  int valore(TextEditingController controller) {
    return int.tryParse(controller.text) ?? 0;
  }

  void salvaPartita() {
    final Partita nuovaPartita = Partita(
      avversario: widget.avversario,
      categoria: widget.categoria,
      risultato: widget.risultato,
      luogo: widget.luogo,
      data: widget.data,

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

      battuta: DatiBattuta(
        battuteEffettuate:
            valore(battuteEffettuate),
        battutePunto:
            valore(battutePunto),
        battuteErrori:
            valore(battuteErrori),
      ),

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

      muro: DatiMuro(
        muriEffettuati:
            valore(muriEffettuati),
        muriPunto:
            valore(muriPunto),
        muriErrori:
            valore(muriErrori),
      ),

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

    archivioPartite.add(nuovaPartita);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Partita salvata!',
        ),
      ),
    );

    Navigator.pop(context);
    Navigator.pop(context);
  }

  Widget campoNumerico(
    String titolo,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: titolo,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget titoloSezione(String testo) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 25,
        bottom: 15,
      ),
      child: Text(
        testo,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scout partita'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Text(
              widget.avversario,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              '${widget.categoria} • '
              '${widget.risultato == 'V' ? 'VINTA' : 'PERSA'}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            // =====================
            // ATTACCO
            // =====================

            titoloSezione('🏐 ATTACCO'),

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

            // =====================
            // BATTUTA
            // =====================

            titoloSezione('🎯 BATTUTA'),

            campoNumerico(
              'Battute effettuate',
              battuteEffettuate,
            ),

            campoNumerico(
              'Ace',
              battutePunto,
            ),

            campoNumerico(
              'Errori battuta',
              battuteErrori,
            ),

            // =====================
            // RICEZIONE
            // =====================

            titoloSezione('👐 RICEZIONE'),

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
              'Errori ricezione',
              ricezioniErrori,
            ),

            // =====================
            // MURO
            // =====================

            titoloSezione('🧱 MURO'),

            campoNumerico(
              'Muri effettuati',
              muriEffettuati,
            ),

            campoNumerico(
              'Muri punto',
              muriPunto,
            ),

            campoNumerico(
              'Errori muro',
              muriErrori,
            ),

            // =====================
            // DIFESA
            // =====================

            titoloSezione('🛡️ DIFESA'),

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
              'Errori difesa',
              difeseErrori,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: salvaPartita,
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'SALVA PARTITA E SCOUT',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}