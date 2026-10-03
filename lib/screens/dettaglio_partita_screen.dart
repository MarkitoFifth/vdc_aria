import 'package:flutter/material.dart';

import '../dati_inseribili/dati.dart';
import '../services/analizzatore_statistiche.dart';

class DettaglioPartitaScreen extends StatelessWidget {
  final Partita partita;

  const DettaglioPartitaScreen({
    super.key,
    required this.partita,
  });

  @override
  Widget build(BuildContext context) {
    final punti =
        AnalizzatoreStatistiche.calcolaPuntiTotali(partita);

    final errori =
        AnalizzatoreStatistiche.calcolaErroriTotali(partita);

    final kill =
        AnalizzatoreStatistiche.calcolaKillPercentuale(
      partita.attacchi,
    );

    final effAttacco =
        AnalizzatoreStatistiche.calcolaEfficienzaAttacco(
      partita.attacchi,
    );

    final ace =
        AnalizzatoreStatistiche.calcolaAcePercentuale(
      partita.battuta,
    );

    final ricezione =
        AnalizzatoreStatistiche.calcolaPositivitaRicezione(
      partita.ricezione,
    );

    final difesa =
        AnalizzatoreStatistiche.calcolaPositivitaDifesa(
      partita.difesa,
    );

    final muro =
        AnalizzatoreStatistiche.calcolaBlockPercentuale(
      partita.muro,
    );

    final bool vinta =
        partita.risultato.toUpperCase() == 'V';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analisi partita'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================================================
            // TESTATA
            // ==================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'vs ${partita.avversario}',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '${partita.categoria} • ${partita.luogo}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    vinta ? 'VINTA' : 'PERSA',
                    style: TextStyle(
                      color: vinta
                          ? Colors.green
                          : Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ==================================================
            // TOTALI
            // ==================================================

            const Text(
              'TOTALI',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _CardStat(
                    titolo: 'Punti',
                    valore: '$punti',
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _CardStat(
                    titolo: 'Errori',
                    valore: '$errori',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ==================================================
            // STATISTICHE
            // ==================================================

            const Text(
              'STATISTICHE',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 10),

            _RigaStatistica(
              titolo: 'Kill%',
              valore: kill,
            ),

            _RigaStatistica(
              titolo: 'Efficienza attacco',
              valore: effAttacco,
            ),

            _RigaStatistica(
              titolo: 'Ace%',
              valore: ace,
            ),

            _RigaStatistica(
              titolo: 'Ricezione positiva',
              valore: ricezione,
            ),

            _RigaStatistica(
              titolo: 'Difesa positiva',
              valore: difesa,
            ),

            _RigaStatistica(
              titolo: 'Muro',
              valore: muro,
            ),
          ],
        ),
      ),
    );
  }
}

class _CardStat extends StatelessWidget {
  final String titolo;
  final String valore;

  const _CardStat({
    required this.titolo,
    required this.valore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            valore,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            titolo,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _RigaStatistica extends StatelessWidget {
  final String titolo;
  final double valore;

  const _RigaStatistica({
    required this.titolo,
    required this.valore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(titolo),
          ),
          Text(
            '${valore.toStringAsFixed(1)}%',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}