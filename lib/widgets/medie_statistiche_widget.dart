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
        AnalizzatoreStatistiche.mediaPositivitaRicezione(partite);

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
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFEAEAEA),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'MEDIE STAGIONALI',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.analytics_outlined,
                    size: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
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
              ultima: true,
            ),

            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              height: 1,
              color: const Color(0xFFF0F0F0),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Analisi completa',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 15,
                  color: Colors.black54,
                ),
              ],
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
  final bool ultima;

  const _StatisticaMedia({
    required this.titolo,
    required this.valore,
    this.ultima = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: ultima ? 0 : 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              titolo,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),

          Text(
            '${valore.toStringAsFixed(1)}%',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}