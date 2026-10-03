import 'package:flutter/material.dart';

import '../dati_inseribili/dati.dart';
import '../services/analizzatore_statistiche.dart';

class DettaglioPartitaScreen
    extends StatelessWidget {
  final Partita partita;

  const DettaglioPartitaScreen({
    super.key,
    required this.partita,
  });

  String percentuale(double valore) {
    return '${valore.toStringAsFixed(1)}%';
  }

  Widget sezione(
    String titolo,
    List<Widget> statistiche,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Text(
              titolo,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ...statistiche,
          ],
        ),
      ),
    );
  }

  Widget riga(
    String nome,
    String valore,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [
          Text(
            nome,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),

          Text(
            valore,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final attacco = partita.attacchi;
    final battuta = partita.battuta;
    final ricezione = partita.ricezione;
    final muro = partita.muro;
    final difesa = partita.difesa;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dettaglio partita',
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Text(
              partita.avversario,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

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

            const SizedBox(height: 10),

            Text(
              'Categoria: ${partita.categoria}',
            ),

            Text(
              partita.luogo == 'C'
                  ? 'Luogo: Casa'
                  : 'Luogo: Fuori casa',
            ),

            Text(
              'Data: '
              '${partita.data.day.toString().padLeft(2, '0')}/'
              '${partita.data.month.toString().padLeft(2, '0')}/'
              '${partita.data.year}',
            ),

            const SizedBox(height: 25),

            // ======================
            // RIEPILOGO
            // ======================

            sezione(
              '📊 Riepilogo',

              [
                riga(
                  'Punti totali',
                  '${AnalizzatoreStatistiche.calcolaPuntiTotali(partita)}',
                ),

                riga(
                  'Errori totali',
                  '${AnalizzatoreStatistiche.calcolaErroriTotali(partita)}',
                ),
              ],
            ),

            // ======================
            // ATTACCO
            // ======================

            sezione(
              '🏐 Attacco',

              [
                riga(
                  'Attacchi',
                  '${attacco.attacchiEffettuati}',
                ),

                riga(
                  'Punti',
                  '${attacco.attacchiPunto}',
                ),

                riga(
                  'Errori',
                  '${attacco.attacchiErrori}',
                ),

                riga(
                  'Murati',
                  '${attacco.attacchiMurati}',
                ),

                riga(
                  'Kill %',
                  percentuale(
                    AnalizzatoreStatistiche
                        .calcolaKillPercentuale(
                      attacco,
                    ),
                  ),
                ),

                riga(
                  'Efficienza',
                  percentuale(
                    AnalizzatoreStatistiche
                        .calcolaEfficienzaAttacco(
                      attacco,
                    ),
                  ),
                ),
              ],
            ),

            // ======================
            // BATTUTA
            // ======================

            sezione(
              '🎯 Battuta',

              [
                riga(
                  'Battute',
                  '${battuta.battuteEffettuate}',
                ),

                riga(
                  'Ace',
                  '${battuta.battutePunto}',
                ),

                riga(
                  'Errori',
                  '${battuta.battuteErrori}',
                ),

                riga(
                  'Ace %',
                  percentuale(
                    AnalizzatoreStatistiche
                        .calcolaAcePercentuale(
                      battuta,
                    ),
                  ),
                ),

                riga(
                  'Errore %',
                  percentuale(
                    AnalizzatoreStatistiche
                        .calcolaErroreBattuta(
                      battuta,
                    ),
                  ),
                ),

                riga(
                  'Efficienza',
                  percentuale(
                    AnalizzatoreStatistiche
                        .calcolaEfficienzaBattuta(
                      battuta,
                    ),
                  ),
                ),
              ],
            ),

            // ======================
            // RICEZIONE
            // ======================

            sezione(
              '👐 Ricezione',

              [
                riga(
                  'Ricezioni',
                  '${ricezione.ricezioniEffettuate}',
                ),

                riga(
                  'Positive',
                  '${ricezione.ricezioniPositive}',
                ),

                riga(
                  'Negative',
                  '${ricezione.ricezioniNegative}',
                ),

                riga(
                  'Errori',
                  '${ricezione.ricezioniErrori}',
                ),

                riga(
                  'Positività',
                  percentuale(
                    AnalizzatoreStatistiche
                        .calcolaPositivitaRicezione(
                      ricezione,
                    ),
                  ),
                ),

                riga(
                  'Efficienza',
                  percentuale(
                    AnalizzatoreStatistiche
                        .calcolaEfficienzaRicezione(
                      ricezione,
                    ),
                  ),
                ),
              ],
            ),

            // ======================
            // MURO
            // ======================

            sezione(
              '🧱 Muro',

              [
                riga(
                  'Muri',
                  '${muro.muriEffettuati}',
                ),

                riga(
                  'Punti',
                  '${muro.muriPunto}',
                ),

                riga(
                  'Errori',
                  '${muro.muriErrori}',
                ),

                riga(
                  'Block %',
                  percentuale(
                    AnalizzatoreStatistiche
                        .calcolaBlockPercentuale(
                      muro,
                    ),
                  ),
                ),

                riga(
                  'Efficienza',
                  percentuale(
                    AnalizzatoreStatistiche
                        .calcolaEfficienzaMuro(
                      muro,
                    ),
                  ),
                ),
              ],
            ),

            // ======================
            // DIFESA
            // ======================

            sezione(
              '🛡️ Difesa',

              [
                riga(
                  'Difese',
                  '${difesa.difeseEffettuate}',
                ),

                riga(
                  'Positive',
                  '${difesa.difesePositive}',
                ),

                riga(
                  'Negative',
                  '${difesa.difeseNegative}',
                ),

                riga(
                  'Errori',
                  '${difesa.difeseErrore}',
                ),

                riga(
                  'Positività',
                  percentuale(
                    AnalizzatoreStatistiche
                        .calcolaPositivitaDifesa(
                      difesa,
                    ),
                  ),
                ),

                riga(
                  'Efficienza',
                  percentuale(
                    AnalizzatoreStatistiche
                        .calcolaEfficienzaDifesa(
                      difesa,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}