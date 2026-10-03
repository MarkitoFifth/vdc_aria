import 'package:flutter/material.dart';

import '../services/archivio_partite.dart';
import '../services/analizzatore_statistiche.dart';
import '../screens/analisi_stagione_screen.dart';

class MedieStatisticheWidget extends StatelessWidget {
  const MedieStatisticheWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final partite = archivioPartite;

    final kill =
        AnalizzatoreStatistiche.mediaKillPercentuale(partite);

    final effAttacco =
        AnalizzatoreStatistiche.mediaEfficienzaAttacco(partite);

    final ace =
        AnalizzatoreStatistiche.mediaAcePercentuale(partite);

    final ricezione =
        AnalizzatoreStatistiche.mediaPositivitaRicezione(
      partite,
    );

    final difesa =
        AnalizzatoreStatistiche.mediaPositivitaDifesa(partite);

    final muro =
        AnalizzatoreStatistiche.mediaBlockPercentuale(partite);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const AnalisiStagioneScreen(),
          ),
        );
      },

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
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
              'MEDIE STAGIONALI',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 16),

            _StatisticaMedia(
              titolo: 'Kill',
              valore: kill,
            ),

            _StatisticaMedia(
              titolo: 'Eff. attacco',
              valore: effAttacco,
            ),

            _StatisticaMedia(
              titolo: 'Ace',
              valore: ace,
            ),

            _StatisticaMedia(
              titolo: 'Ricezione',
              valore: ricezione,
            ),

            _StatisticaMedia(
              titolo: 'Difesa',
              valore: difesa,
            ),

            _StatisticaMedia(
              titolo: 'Muro',
              valore: muro,
            ),

            const SizedBox(height: 4),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Tutte le statistiche →',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatisticaMedia extends StatelessWidget {
  final String titolo;
  final double valore;

  const _StatisticaMedia({
    required this.titolo,
    required this.valore,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        children: [
          Expanded(
            child: Text(
              titolo,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Text(
            '${valore.toStringAsFixed(1)}%',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}