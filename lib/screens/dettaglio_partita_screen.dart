import 'package:flutter/material.dart';

import '../dati_inseribili/dati.dart';

class DettaglioPartitaScreen extends StatelessWidget {
  final Partita partita;

  const DettaglioPartitaScreen({
    super.key,
    required this.partita,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dettaglio partita'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // ==================================
            // AVVERSARIO
            // ==================================

            Text(
              partita.avversario,

              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            // ==================================
            // RISULTATO
            // ==================================

            Text(
              partita.risultato == 'V'
                  ? 'VINTA'
                  : 'PERSA',

              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,

                color:
                    partita.risultato == 'V'
                        ? Colors.green
                        : Colors.red,
              ),
            ),

            const SizedBox(height: 20),

            // ==================================
            // CATEGORIA
            // ==================================

            Text(
              'Categoria: ${partita.categoria}',

              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            // ==================================
            // LUOGO
            // ==================================

            Text(
              partita.luogo == 'C'
                  ? 'Luogo: Casa'
                  : 'Luogo: Fuori casa',

              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            // ==================================
            // DATA
            // ==================================

            Text(
              'Data: '
              '${partita.data.day.toString().padLeft(2, '0')}/'
              '${partita.data.month.toString().padLeft(2, '0')}/'
              '${partita.data.year}',

              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}