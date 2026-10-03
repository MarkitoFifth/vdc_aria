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
        archivioPartite.reversed.take(5).toList();

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
            // ================================================
            // TITOLO
            // ================================================

            const Text(
              'ULTIME PARTITE',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 14),

            // ================================================
            // LISTA
            // ================================================

            if (ultimePartite.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Nessuna partita',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              )
            else
              ...ultimePartite.map(
                (partita) {
                  final bool vinta =
                      partita.risultato.toUpperCase() == 'V';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DettaglioPartitaScreen(
                            partita: partita,
                          ),
                        ),
                      );
                    },

                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 12,
                      ),

                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              partita.avversario,
                              overflow:
                                  TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ),

                          Text(
                            vinta ? 'V' : 'P',
                            style: TextStyle(
                              color: vinta
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

            // ================================================
            // VEDI TUTTE
            // ================================================

            const SizedBox(height: 2),

            Align(
              alignment: Alignment.centerRight,

              child: Text(
                'Vedi tutte →',
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