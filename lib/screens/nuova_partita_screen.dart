import 'package:flutter/material.dart';

import '../screens/scout_partita_screen.dart';

class NuovaPartitaScreen extends StatefulWidget {
  const NuovaPartitaScreen({super.key});

  @override
  State<NuovaPartitaScreen> createState() =>
      _NuovaPartitaScreenState();
}

class _NuovaPartitaScreenState
    extends State<NuovaPartitaScreen> {
  final TextEditingController avversarioController =
      TextEditingController();

  String categoriaSelezionata = 'Serie C';
  String risultatoSelezionato = 'V';
  String luogoSelezionato = 'C';

  DateTime? dataSelezionata;

  Future<void> selezionaData() async {
    final DateTime? data = await showDatePicker(
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

  void continuaScouting() {
    if (avversarioController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Inserisci la squadra avversaria',
          ),
        ),
      );

      return;
    }

    if (dataSelezionata == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Seleziona la data della partita',
          ),
        ),
      );

      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ScoutPartitaScreen(
            avversario:
                avversarioController.text.trim(),
            categoria: categoriaSelezionata,
            risultato: risultatoSelezionato,
            luogo: luogoSelezionato,
            data: dataSelezionata!,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    avversarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuova partita'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
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

            const Text(
              'Categoria',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: categoriaSelezionata,
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
                  child: const Text(
                    'Seleziona data',
                  ),
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

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: continuaScouting,
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'CONTINUA CON LO SCOUT',
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