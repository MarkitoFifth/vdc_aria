import 'package:flutter/material.dart';
import 'package:vdc_aria/screens/dettaglio_partita_screen.dart';

import '../services/archivio_partite.dart';
import 'dettaglio_partita_screen.dart';

class TuttePartiteScreen extends StatelessWidget {
  const TuttePartiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutte le partite'),
      ),

      body: archivioPartite.isEmpty
          ? const Center(
              child: Text(
                'Non ci sono partite.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )

          : ListView.builder(
              itemCount: archivioPartite.length,

              itemBuilder: (context, index) {
                final partita = archivioPartite[index];

                return ListTile(
                  title: Text(
                    partita.avversario,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  trailing: Text(
                    partita.risultato == 'V'
                        ? 'VINTA'
                        : 'PERSA',

                    style: TextStyle(
                      fontWeight: FontWeight.bold,

                      color:
                          partita.risultato == 'V'
                              ? Colors.green
                              : Colors.red,
                    ),
                  ),

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
                );
              },
            ),
    );
  }
}