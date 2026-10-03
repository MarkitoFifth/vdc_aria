import 'package:flutter/material.dart';

import '../services/archivio_partite.dart';
import '../services/analizzatore_statistiche.dart';

class AnalisiStagioneScreen extends StatelessWidget {
  const AnalisiStagioneScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final partite = archivioPartite;

    // ==============================
    // TOTALI STAGIONE
    // ==============================

    int puntiTotali = 0;
    int erroriTotali = 0;
    int vittorie = 0;
    int sconfitte = 0;

    for (final partita in partite) {
      puntiTotali +=
          AnalizzatoreStatistiche.calcolaPuntiTotali(partita);

      erroriTotali +=
          AnalizzatoreStatistiche.calcolaErroriTotali(partita);

      if (partita.risultato.toUpperCase() == 'V') {
        vittorie++;
      } else {
        sconfitte++;
      }
    }

    // ==============================
    // MEDIE / PERCENTUALI
    // ==============================

    final kill =
        AnalizzatoreStatistiche.mediaKillPercentuale(partite);

    final effAttacco =
        AnalizzatoreStatistiche.mediaEfficienzaAttacco(
      partite,
    );

    final ace =
        AnalizzatoreStatistiche.mediaAcePercentuale(partite);

    final effBattuta =
        AnalizzatoreStatistiche.mediaEfficienzaBattuta(
      partite,
    );

    final ricezione =
        AnalizzatoreStatistiche.mediaPositivitaRicezione(
      partite,
    );

    final effRicezione =
        AnalizzatoreStatistiche.mediaEfficienzaRicezione(
      partite,
    );

    final difesa =
        AnalizzatoreStatistiche.mediaPositivitaDifesa(
      partite,
    );

    final effDifesa =
        AnalizzatoreStatistiche.mediaEfficienzaDifesa(
      partite,
    );

    final muro =
        AnalizzatoreStatistiche.mediaBlockPercentuale(
      partite,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistiche stagione'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================================================
            // BILANCIO STAGIONE
            // ==================================================

            const Text(
              'BILANCIO STAGIONE',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 10),

            // Prima riga
            Row(
              children: [
                Expanded(
                  child: _CardStat(
                    titolo: 'Partite',
                    valore: '${partite.length}',
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _CardStat(
                    titolo: 'Vittorie',
                    valore: '$vittorie',
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _CardStat(
                    titolo: 'Sconfitte',
                    valore: '$sconfitte',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Seconda riga
            Row(
              children: [
                Expanded(
                  child: _CardStat(
                    titolo: 'Punti totali',
                    valore: '$puntiTotali',
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _CardStat(
                    titolo: 'Errori totali',
                    valore: '$erroriTotali',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ==================================================
            // ATTACCO
            // ==================================================

            const Text(
              'ATTACCO',
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
              titolo: 'Efficienza',
              valore: effAttacco,
            ),

            const SizedBox(height: 20),

            // ==================================================
            // BATTUTA
            // ==================================================

            const Text(
              'BATTUTA',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 10),

            _RigaStatistica(
              titolo: 'Ace%',
              valore: ace,
            ),

            _RigaStatistica(
              titolo: 'Efficienza',
              valore: effBattuta,
            ),

            const SizedBox(height: 20),

            // ==================================================
            // RICEZIONE
            // ==================================================

            const Text(
              'RICEZIONE',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 10),

            _RigaStatistica(
              titolo: 'Positività',
              valore: ricezione,
            ),

            _RigaStatistica(
              titolo: 'Efficienza',
              valore: effRicezione,
            ),

            const SizedBox(height: 20),

            // ==================================================
            // DIFESA
            // ==================================================

            const Text(
              'DIFESA',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 10),

            _RigaStatistica(
              titolo: 'Positività',
              valore: difesa,
            ),

            _RigaStatistica(
              titolo: 'Efficienza',
              valore: effDifesa,
            ),

            const SizedBox(height: 20),

            // ==================================================
            // MURO
            // ==================================================

            const Text(
              'MURO',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 10),

            _RigaStatistica(
              titolo: 'Muri punto %',
              valore: muro,
            ),

            const SizedBox(height: 20),
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
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [
          Text(
            valore,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            titolo,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
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