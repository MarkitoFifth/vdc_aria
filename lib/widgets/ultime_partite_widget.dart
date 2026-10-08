import 'package:flutter/material.dart';

import '../services/archivio_partite.dart';
import '../screens/tutte_partite_screen.dart';
import '../screens/dettaglio_partita_screen.dart';

class UltimePartiteWidget extends StatelessWidget {
  const UltimePartiteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ultimePartite =
        archivioPartite.reversed.take(3).toList();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const TuttePartiteScreen(),
          ),
        );
      },
      child: Container(
        width: double.infinity,

        padding: const EdgeInsets.fromLTRB(
          18,
          18,
          18,
          15,
        ),

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
            // =================================================
            // HEADER
            // =================================================

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'ULTIME PARTITE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),

                Container(
                  width: 28,
                  height: 28,

                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius:
                        BorderRadius.circular(9),
                  ),

                  child: const Icon(
                    Icons.history_rounded,
                    size: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // =================================================
            // PARTITE
            // =================================================

            Expanded(
              child: ultimePartite.isEmpty
                  ? const Center(
                      child: Text(
                        'Nessuna partita',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        for (int i = 0;
                            i < ultimePartite.length;
                            i++)
                          Expanded(
                            child: _PartitaRow(
                              partita:
                                  ultimePartite[i],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DettaglioPartitaScreen(
                                      partita:
                                          ultimePartite[i],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
            ),

            // =================================================
            // FOOTER
            // =================================================

            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              height: 1,
              color: const Color(0xFFF0F0F0),
            ),

            const SizedBox(height: 9),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end,
              children: [
                Text(
                  'Vedi tutte',
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

// =============================================================
// RIGA SINGOLA PARTITA
// =============================================================

class _PartitaRow extends StatelessWidget {
  final dynamic partita;
  final VoidCallback onTap;

  const _PartitaRow({
    required this.partita,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool vinta =
        partita.risultato.toUpperCase() == 'V';

    final String data =
        '${partita.data.day.toString().padLeft(2, '0')}/'
        '${partita.data.month.toString().padLeft(2, '0')}';

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,

      child: Row(
        children: [
          // =================================================
          // V / P
          // =================================================

          Container(
            width: 34,
            height: 34,

            decoration: BoxDecoration(
              color: vinta
                  ? const Color(0xFFEAF6EE)
                  : const Color(0xFFFBECEC),

              borderRadius:
                  BorderRadius.circular(11),
            ),

            child: Icon(
              vinta
                  ? Icons.check_rounded
                  : Icons.close_rounded,

              size: 17,

              color: vinta
                  ? const Color(0xFF248A49)
                  : const Color(0xFFC63D3D),
            ),
          ),

          const SizedBox(width: 9),

          // =================================================
          // INFORMAZIONI
          // =================================================

          Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  partita.avversario,

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  '$data • ${partita.categoria}',

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style: TextStyle(
                    fontSize: 9.5,
                    color:
                        Colors.grey.shade600,
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // =================================================
          // FRECCETTA
          // =================================================

          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 11,
            color: Colors.black38,
          ),
        ],
      ),
    );
  }
}
