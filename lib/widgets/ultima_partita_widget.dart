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
          border: Border.all(
            color: const Color(0xFFEAEAEA),
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TitoloSezione(),
            SizedBox(height: 20),
            Text(
              'Nessuna partita registrata',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'La tua prossima partita apparirà qui.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
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
                  child: _TitoloSezione(),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: vinta
                        ? const Color(0xFFEAF6EE)
                        : const Color(0xFFFBECEC),
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        vinta
                            ? Icons.check_rounded
                            : Icons.close_rounded,
                        size: 13,
                        color: vinta
                            ? const Color(0xFF248A49)
                            : const Color(0xFFC63D3D),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        vinta ? 'VINTA' : 'PERSA',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          color: vinta
                              ? const Color(0xFF248A49)
                              : const Color(0xFFC63D3D),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(
                    Icons.sports_volleyball_rounded,
                    size: 21,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'vs ${partita.avversario}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${partita.categoria} • ${partita.luogo}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _StatisticaPrincipale(
                      valore: '$punti',
                      titolo: 'PUNTI',
                    ),
                  ),
                  _Separatore(),
                  Expanded(
                    child: _StatisticaPrincipale(
                      valore:
                          '${kill.toStringAsFixed(1)}%',
                      titolo: 'KILL',
                    ),
                  ),
                  _Separatore(),
                  Expanded(
                    child: _StatisticaPrincipale(
                      valore:
                          '${ricezione.toStringAsFixed(1)}%',
                      titolo: 'RICEZ.',
                    ),
                  ),
                  _Separatore(),
                  Expanded(
                    child: _StatisticaPrincipale(
                      valore: '$muri',
                      titolo: 'MURI',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 13),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end,
              children: [
                Text(
                  'Visualizza partita',
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

class _TitoloSezione extends StatelessWidget {
  const _TitoloSezione();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'ULTIMA PARTITA',
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.1,
        color: Colors.black87,
      ),
    );
  }
}

class _Separatore extends StatelessWidget {
  const _Separatore();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 27,
      color: const Color(0xFFDDDDDD),
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
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          titolo,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}