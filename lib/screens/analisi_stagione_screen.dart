import 'package:flutter/material.dart';

import '../services/archivio_partite.dart';
import '../services/analizzatore_statistiche.dart';

class AnalisiStagioneScreen extends StatelessWidget {
  const AnalisiStagioneScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final partite = archivioPartite;

    int puntiTotali = 0;
    int erroriTotali = 0;
    int vittorie = 0;
    int sconfitte = 0;

    for (final partita in partite) {
      puntiTotali +=
          AnalizzatoreStatistiche.calcolaPuntiTotali(
        partita,
      );

      erroriTotali +=
          AnalizzatoreStatistiche.calcolaErroriTotali(
        partita,
      );

      if (partita.risultato.toUpperCase() == 'V') {
        vittorie++;
      } else {
        sconfitte++;
      }
    }

    final double percentualeVittorie =
        partite.isEmpty
            ? 0
            : (vittorie / partite.length) * 100;

    final kill =
        AnalizzatoreStatistiche.mediaKillPercentuale(
      partite,
    );

    final effAttacco =
        AnalizzatoreStatistiche.mediaEfficienzaAttacco(
      partite,
    );

    final ace =
        AnalizzatoreStatistiche.mediaAcePercentuale(
      partite,
    );

    final effBattuta =
        AnalizzatoreStatistiche.mediaEfficienzaBattuta(
      partite,
    );

    final ricezione =
        AnalizzatoreStatistiche.mediaPositivitaRicezione(
      partite,
    );

    final effRicezione =
        AnalizzatoreStatistiche.mediaEfficienzaRicezione(
      partite,
    );

    final difesa =
        AnalizzatoreStatistiche.mediaPositivitaDifesa(
      partite,
    );

    final effDifesa =
        AnalizzatoreStatistiche.mediaEfficienzaDifesa(
      partite,
    );

    final muro =
        AnalizzatoreStatistiche.mediaBlockPercentuale(
      partite,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFF5F5F5),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Analisi stagione',
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
            // OVERVIEW
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
                      const Expanded(
                        child: Text(
                          'STAGIONE',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight:
                                FontWeight.w800,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.10),
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.analytics_outlined,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 17),

                  Text(
                    '${partite.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      height: 0.95,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.5,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'partite registrate',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.white12,
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: _OverviewDato(
                          valore: '$vittorie',
                          titolo: 'VITTORIE',
                        ),
                      ),
                      Expanded(
                        child: _OverviewDato(
                          valore: '$sconfitte',
                          titolo: 'SCONFITTE',
                        ),
                      ),
                      Expanded(
                        child: _OverviewDato(
                          valore:
                              '${percentualeVittorie.toStringAsFixed(0)}%',
                          titolo: 'WIN RATE',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // ============================
            // TOTALI
            // ============================

            const _TitoloSezione(
              titolo: 'TOTALI',
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _NumeroCard(
                    valore: '$puntiTotali',
                    titolo: 'PUNTI',
                    icona: Icons
                        .add_circle_outline_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _NumeroCard(
                    valore: '$erroriTotali',
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

            _BloccoStatistico(
              titolo: 'ATTACCO',
              icona: Icons.flash_on_rounded,
              statistiche: [
                _Statistica(
                  titolo: 'Kill',
                  valore: kill,
                ),
                _Statistica(
                  titolo: 'Efficienza',
                  valore: effAttacco,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ============================
            // BATTUTA
            // ============================

            _BloccoStatistico(
              titolo: 'BATTUTA',
              icona: Icons
                  .sports_volleyball_outlined,
              statistiche: [
                _Statistica(
                  titolo: 'Ace',
                  valore: ace,
                ),
                _Statistica(
                  titolo: 'Efficienza',
                  valore: effBattuta,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ============================
            // RICEZIONE
            // ============================

            _BloccoStatistico(
              titolo: 'RICEZIONE',
              icona: Icons
                  .pan_tool_alt_outlined,
              statistiche: [
                _Statistica(
                  titolo: 'Positività',
                  valore: ricezione,
                ),
                _Statistica(
                  titolo: 'Efficienza',
                  valore: effRicezione,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ============================
            // DIFESA
            // ============================

            _BloccoStatistico(
              titolo: 'DIFESA',
              icona: Icons.shield_outlined,
              statistiche: [
                _Statistica(
                  titolo: 'Positività',
                  valore: difesa,
                ),
                _Statistica(
                  titolo: 'Efficienza',
                  valore: effDifesa,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ============================
            // MURO
            // ============================

            _BloccoStatistico(
              titolo: 'MURO',
              icona:
                  Icons.vertical_align_top_rounded,
              statistiche: [
                _Statistica(
                  titolo: 'Muri punto',
                  valore: muro,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewDato extends StatelessWidget {
  final String valore;
  final String titolo;

  const _OverviewDato({
    required this.valore,
    required this.titolo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          valore,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          titolo,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 8.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ],
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

class _NumeroCard extends StatelessWidget {
  final String valore;
  final String titolo;
  final IconData icona;

  const _NumeroCard({
    required this.valore,
    required this.titolo,
    required this.icona,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
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
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius:
                  BorderRadius.circular(11),
            ),
            child: Icon(
              icona,
              size: 17,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                valore,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                titolo,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Statistica {
  final String titolo;
  final double valore;

  const _Statistica({
    required this.titolo,
    required this.valore,
  });
}

class _BloccoStatistico extends StatelessWidget {
  final String titolo;
  final IconData icona;
  final List<_Statistica> statistiche;

  const _BloccoStatistico({
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
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius:
                      BorderRadius.circular(11),
                ),
                child: Icon(
                  icona,
                  size: 17,
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

          const SizedBox(height: 15),

          ...statistiche.asMap().entries.map(
            (entry) {
              final bool ultima =
                  entry.key ==
                      statistiche.length - 1;

              final statistica = entry.value;

              return Padding(
                padding: EdgeInsets.only(
                  bottom: ultima ? 0 : 12,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            statistica.titolo,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight:
                                  FontWeight.w600,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        Text(
                          '${statistica.valore.toStringAsFixed(1)}%',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight:
                                FontWeight.w900,
                          ),
                        ),
                      ],
                    ),

                    if (!ultima)
                      const SizedBox(height: 9),

                    if (!ultima)
                      Container(
                        height: 1,
                        color:
                            const Color(0xFFF1F1F1),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}