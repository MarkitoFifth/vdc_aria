import 'package:flutter/material.dart';

import '../dati_inseribili/dati.dart';
import '../services/archivio_partite.dart';

class NuovaPartitaScreen extends StatefulWidget {
  const NuovaPartitaScreen({super.key});

  @override
  State<NuovaPartitaScreen> createState() => _NuovaPartitaScreenState();
}

class _NuovaPartitaScreenState extends State<NuovaPartitaScreen> {
  // Controller del campo "Avversario"
  final TextEditingController avversarioController =
      TextEditingController();

  // Dati selezionati
  String categoriaSelezionata = 'Serie C';
  String risultatoSelezionato = 'V';
  String luogoSelezionato = 'C';

  DateTime? dataSelezionata;

  // ==========================================
  // SELEZIONE DATA
  // ==========================================

  Future<void> selezionaData() async {
    DateTime? data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (data != null) {
      setState(() {
        dataSelezionata = data;
      });
    }
  }

  // ==========================================
  // SALVA PARTITA
  // ==========================================

  void salvaPartita() {
    // Controllo avversario
    if (avversarioController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Inserisci la squadra avversaria'),
        ),
      );

      return;
    }

    // Controllo data
    if (dataSelezionata == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Seleziona la data della partita'),
        ),
      );

      return;
    }

    // Creazione della partita
    final Partita nuovaPartita = Partita(
      avversario: avversarioController.text.trim(),
      categoria: categoriaSelezionata,
      risultato: risultatoSelezionato,
      luogo: luogoSelezionato,
      data: dataSelezionata!,
    );

    // Aggiungiamo la partita all'archivio
    archivioPartite.add(nuovaPartita);

    // Torniamo alla Home
    Navigator.pop(context);
  }

  // ==========================================
  // DISPOSE
  // ==========================================

  @override
  void dispose() {
    avversarioController.dispose();
    super.dispose();
  }

  // ==========================================
  // INTERFACCIA
  // ==========================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuova partita'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // ==================================
            // AVVERSARIO
            // ==================================

            const Text(
              'Squadra avversaria',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: avversarioController,
              decoration: const InputDecoration(
                hintText: 'Es. Sorrento',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            // ==================================
            // CATEGORIA
            // ==================================

            const Text(
              'Categoria',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: categoriaSelezionata,

              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),

              items: const [
                DropdownMenuItem(
                  value: 'Serie C',
                  child: Text('Serie C'),
                ),

                DropdownMenuItem(
                  value: 'Under 19',
                  child: Text('Under 19'),
                ),
              ],

              onChanged: (valore) {
                if (valore == null) return;

                setState(() {
                  categoriaSelezionata = valore;
                });
              },
            ),

            const SizedBox(height: 25),

            // ==================================
            // RISULTATO
            // ==================================

            const Text(
              'Risultato',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            RadioListTile<String>(
              title: const Text('Vinta'),
              value: 'V',
              groupValue: risultatoSelezionato,

              onChanged: (valore) {
                if (valore == null) return;

                setState(() {
                  risultatoSelezionato = valore;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Persa'),
              value: 'S',
              groupValue: risultatoSelezionato,

              onChanged: (valore) {
                if (valore == null) return;

                setState(() {
                  risultatoSelezionato = valore;
                });
              },
            ),

            const SizedBox(height: 15),

            // ==================================
            // LUOGO
            // ==================================

            const Text(
              'Luogo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            RadioListTile<String>(
              title: const Text('Casa'),
              value: 'C',
              groupValue: luogoSelezionato,

              onChanged: (valore) {
                if (valore == null) return;

                setState(() {
                  luogoSelezionato = valore;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Fuori casa'),
              value: 'F',
              groupValue: luogoSelezionato,

              onChanged: (valore) {
                if (valore == null) return;

                setState(() {
                  luogoSelezionato = valore;
                });
              },
            ),

            const SizedBox(height: 15),

            // ==================================
            // DATA
            // ==================================

            const Text(
              'Data della partita',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                ElevatedButton(
                  onPressed: selezionaData,
                  child: const Text('Seleziona data'),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Text(
                    dataSelezionata == null
                        ? 'Nessuna data'
                        : '${dataSelezionata!.day.toString().padLeft(2, '0')}/'
                          '${dataSelezionata!.month.toString().padLeft(2, '0')}/'
                          '${dataSelezionata!.year}',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 35),

            // ==================================
            // SALVA
            // ==================================

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: salvaPartita,

                child: const Padding(
                  padding: EdgeInsets.all(15),

                  child: Text(
                    'SALVA PARTITA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}