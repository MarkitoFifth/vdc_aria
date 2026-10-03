import 'package:flutter/material.dart';

import '../services/archivio_partite.dart';
import '../services/archivio_stagioni.dart';
import '../dati_inseribili/dati.dart';
import 'dettaglio_partita_screen.dart';

class TuttePartiteScreen extends StatefulWidget {
  const TuttePartiteScreen({
    super.key,
  });

  @override
  State<TuttePartiteScreen> createState() =>
      _TuttePartiteScreenState();
}

class _TuttePartiteScreenState
    extends State<TuttePartiteScreen> {

  Future<void> eliminaPartita(Partita partita) async {
    final bool? conferma = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Eliminare la partita?',
          ),
          content: Text(
            'VS ${partita.avversario}\n'
            '${partita.risultato}\n\n'
            'La partita verrà eliminata anche '
            'dalle statistiche e dai grafici.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text(
                'Annulla',
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: const Text(
                'Elimina',
              ),
            ),
          ],
        );
      },
    );

    if (conferma != true) {
      return;
    }

    await ArchivioStagioni.eliminaPartita(
      partita,
    );

    if (!mounted) return;

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Partita eliminata.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Partita> partite =
        archivioPartite.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tutte le partite',
        ),
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

              separatorBuilder:
                  (context, index) =>
                      const SizedBox(height: 10),

              itemBuilder: (context, index) {
                final partita = partite[index];

                final bool vinta =
                    partita.risultato
                            .toUpperCase() ==
                        'V';

                return Container(
                  padding:
                      const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(16),
                  ),

                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          borderRadius:
                              BorderRadius.circular(12),

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
                            padding:
                                const EdgeInsets.symmetric(
                              vertical: 4,
                            ),

                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  partita.avversario,
                                  style:
                                      const TextStyle(
                                    fontSize: 17,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 5,
                                ),

                                Text(
                                  '${partita.categoria} • ${partita.luogo}',
                                  style: TextStyle(
                                    color: Colors
                                        .grey
                                        .shade600,
                                    fontSize: 13,
                                  ),
                                ),

                                const SizedBox(
                                  height: 4,
                                ),

                                Text(
                                  '${partita.data.day.toString().padLeft(2, '0')}/'
                                  '${partita.data.month.toString().padLeft(2, '0')}/'
                                  '${partita.data.year}',
                                  style: TextStyle(
                                    color: Colors
                                        .grey
                                        .shade500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),

                        decoration:
                            BoxDecoration(
                          color: vinta
                              ? Colors.green
                                  .withOpacity(0.12)
                              : Colors.red
                                  .withOpacity(0.12),
                          borderRadius:
                              BorderRadius.circular(
                            20,
                          ),
                        ),

                        child: Text(
                          vinta
                              ? 'VINTA'
                              : 'PERSA',

                          style: TextStyle(
                            color: vinta
                                ? Colors.green
                                : Colors.red,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 4),

                      IconButton(
                        tooltip:
                            'Elimina partita',

                        onPressed: () =>
                            eliminaPartita(
                          partita,
                        ),

                        icon: const Icon(
                          Icons.delete_outline,
                        ),
                      ),

                      const Icon(
                        Icons.chevron_right,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}