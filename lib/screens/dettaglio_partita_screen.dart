import 'package:flutter/material.dart';

import '../dati_inseribili/dati.dart';
import '../services/analizzatore_statistiche.dart';

class DettaglioPartitaScreen extends StatelessWidget {
  final Partita partita;

  const DettaglioPartitaScreen({
    super.key,
    required this.partita,
  });

  @override
  Widget build(BuildContext context) {
    final punti =
        AnalizzatoreStatistiche.calcolaPuntiTotali(
      partita,
    );

    final errori =
        AnalizzatoreStatistiche.calcolaErroriTotali(
      partita,
    );

    final kill =
        AnalizzatoreStatistiche.calcolaKillPercentuale(
      partita.attacchi,
    );

    final effAttacco =
        AnalizzatoreStatistiche.calcolaEfficienzaAttacco(
      partita.attacchi,
    );

    final ace =
        AnalizzatoreStatistiche.calcolaAcePercentuale(
      partita.battuta,
    );

    final ricezione =
        AnalizzatoreStatistiche.calcolaPositivitaRicezione(
      partita.ricezione,
    );

    final difesa =
        AnalizzatoreStatistiche.calcolaPositivitaDifesa(
      partita.difesa,
    );

    final muro =
        AnalizzatoreStatistiche.calcolaBlockPercentuale(
      partita.muro,
    );

    final bool vinta =
        partita.risultato.toUpperCase() == 'V';

    final String data =
        '${partita.data.day.toString().padLeft(2, '0')}/'
        '${partita.data.month.toString().padLeft(2, '0')}/'
        '${partita.data.year}';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFF5F5F5),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Analisi partita',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          16,
          4,
          16,
          30,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // ============================
            // HEADER PARTITA
            // ============================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                borderRadius:
                    BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.10),
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons
                              .sports_volleyball_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),

                      const Spacer(),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: vinta
                              ? const Color(0xFF1D3A29)
                              : const Color(0xFF3A2222),
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        child: Text(
                          vinta ? 'VINTA' : 'PERSA',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight:
                                FontWeight.w800,
                            color: vinta
                                ? const Color(
                                    0xFF7FE09F,
                                  )
                                : const Color(
                                    0xFFFF8F8F,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'VS ${partita.avversario.toUpperCase()}',
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.7,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    '${partita.categoria} • '
                    '${partita.luogo}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    data,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ============================
            // TOTALI
            // ============================

            const _TitoloSezione(
              titolo: 'RISULTATO',
            ),

            const SizedBox(height: 9),

            Row(
              children: [
                Expanded(
                  child: _TotaleCard(
                    valore: '$punti',
                    titolo: 'PUNTI',
                    icona: Icons
                        .add_circle_outline_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _TotaleCard(
                    valore: '$errori',
                    titolo: 'ERRORI',
                    icona: Icons
                        .warning_amber_rounded,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // ============================
            // ATTACCO
            // ============================

            _SezioneStatistica(
              titolo: 'ATTACCO',
              icona: Icons.flash_on_rounded,
              statistiche: [
                _DatoStatistica(
                  'Kill',
                  kill,
                ),
                _DatoStatistica(
                  'Efficienza',
                  effAttacco,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ============================
            // BATTUTA
            // ============================

            _SezioneStatistica(
              titolo: 'BATTUTA',
              icona: Icons
                  .sports_volleyball_outlined,
              statistiche: [
                _DatoStatistica(
                  'Ace',
                  ace,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ============================
            // RICEZIONE
            // ============================

            _SezioneStatistica(
              titolo: 'RICEZIONE',
              icona: Icons
                  .pan_tool_alt_outlined,
              statistiche: [
                _DatoStatistica(
                  'Positività',
                  ricezione,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ============================
            // DIFESA
            // ============================

            _SezioneStatistica(
              titolo: 'DIFESA',
              icona: Icons
                  .shield_outlined,
              statistiche: [
                _DatoStatistica(
                  'Positività',
                  difesa,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ============================
            // MURO
            // ============================

            _SezioneStatistica(
              titolo: 'MURO',
              icona: Icons
                  .vertical_align_top_rounded,
              statistiche: [
                _DatoStatistica(
                  'Muri punto',
                  muro,
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
  final String titolo;

  const _TitoloSezione({
    required this.titolo,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      titolo,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.1,
      ),
    );
  }
}

class _TotaleCard extends StatelessWidget {
  final String valore;
  final String titolo;
  final IconData icona;

  const _TotaleCard({
    required this.valore,
    required this.titolo,
    required this.icona,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE8E8E8),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius:
                  BorderRadius.circular(11),
            ),
            child: Icon(
              icona,
              size: 18,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 11),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                valore,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                titolo,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade600,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DatoStatistica {
  final String titolo;
  final double valore;

  const _DatoStatistica(
    this.titolo,
    this.valore,
  );
}

class _SezioneStatistica
    extends StatelessWidget {
  final String titolo;
  final IconData icona;
  final List<_DatoStatistica> statistiche;

  const _SezioneStatistica({
    required this.titolo,
    required this.icona,
    required this.statistiche,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE8E8E8),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius:
                      BorderRadius.circular(10),
                ),
                child: Icon(
                  icona,
                  size: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                titolo,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          ...statistiche.map(
            (statistica) => Padding(
              padding:
                  const EdgeInsets.only(bottom: 9),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      statistica.titolo,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '${statistica.valore.toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}