import 'package:flutter/material.dart';

import '../services/archivio_partite.dart';
import '../services/analizzatore_statistiche.dart';
import '../dati_inseribili/dati.dart';
import '../screens/dettaglio_partita_screen.dart';

class UltimaPartitaWidget extends StatelessWidget {
  const UltimaPartitaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (archivioPartite.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ULTIMA PARTITA',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nessuna partita registrata',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    final Partita partita = archivioPartite.last;

    final punti =
        AnalizzatoreStatistiche.calcolaPuntiTotali(partita);

    final kill =
        AnalizzatoreStatistiche.calcolaKillPercentuale(
      partita.attacchi,
    );

    final ricezione =
        AnalizzatoreStatistiche.calcolaPositivitaRicezione(
      partita.ricezione,
    );

    final muri = partita.muro.muriPunto;

    final bool vinta =
        partita.risultato.toUpperCase() == 'V';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DettaglioPartitaScreen(
              partita: partita,
            ),
          ),
        );
      },

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ULTIMA PARTITA',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Text(
                    'vs ${partita.avversario}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: vinta
                        ? Colors.green.withOpacity(0.12)
                        : Colors.red.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    vinta ? 'VINTA' : 'PERSA',
                    style: TextStyle(
                      color: vinta
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Text(
              '${partita.categoria} • ${partita.luogo}',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 22),

            Row(
              children: [
                Expanded(
                  child: _StatisticaPrincipale(
                    valore: '$punti',
                    titolo: 'PUNTI',
                  ),
                ),

                Expanded(
                  child: _StatisticaPrincipale(
                    valore: '${kill.toStringAsFixed(1)}%',
                    titolo: 'KILL%',
                  ),
                ),

                Expanded(
                  child: _StatisticaPrincipale(
                    valore:
                        '${ricezione.toStringAsFixed(1)}%',
                    titolo: 'RICEZIONE',
                  ),
                ),

                Expanded(
                  child: _StatisticaPrincipale(
                    valore: '$muri',
                    titolo: 'MURI',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Visualizza analisi →',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatisticaPrincipale extends StatelessWidget {
  final String valore;
  final String titolo;

  const _StatisticaPrincipale({
    required this.valore,
    required this.titolo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          valore,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          titolo,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}