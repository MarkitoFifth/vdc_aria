import 'package:flutter/material.dart';

import '../services/archivio_partite.dart';
import '../dati_inseribili/dati.dart';
import 'dettaglio_partita_screen.dart';

class TuttePartiteScreen extends StatelessWidget {
  const TuttePartiteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Partita> partite =
        archivioPartite.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutte le partite'),
      ),

      body: partite.isEmpty
          ? const Center(
              child: Text(
                'Nessuna partita registrata',
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: partite.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 10),

              itemBuilder: (context, index) {
                final partita = partite[index];

                final bool vinta =
                    partita.risultato.toUpperCase() == 'V';

                return InkWell(
                  borderRadius: BorderRadius.circular(16),

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

                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                partita.avversario,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                '${partita.categoria} • ${partita.luogo}',
                                style: TextStyle(
                                  color:
                                      Colors.grey.shade600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: vinta
                                ? Colors.green
                                    .withOpacity(0.12)
                                : Colors.red
                                    .withOpacity(0.12),
                            borderRadius:
                                BorderRadius.circular(20),
                          ),
                          child: Text(
                            vinta ? 'VINTA' : 'PERSA',
                            style: TextStyle(
                              color: vinta
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        const Icon(
                          Icons.chevron_right,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}