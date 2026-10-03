import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../services/archivio_partite.dart';
import '../services/analizzatore_statistiche.dart';

class GraficiScreen extends StatelessWidget {
  const GraficiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        title: const Text(
          'Analisi andamento',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: archivioPartite.isEmpty
          ? const Center(
              child: Text(
                'Non ci sono ancora partite.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // ==================================================
                  // ATTACCO
                  // ==================================================

                  _sezioneGrafico(
                    titolo: 'ATTACCO',
                    sottotitolo:
                        'Andamento di Kill% ed efficienza',
                    grafico: _graficoAttacco(),
                  ),

                  const SizedBox(height: 16),

                  // ==================================================
                  // BATTUTA
                  // ==================================================

                  _sezioneGrafico(
                    titolo: 'BATTUTA',
                    sottotitolo:
                        'Andamento di Ace% ed efficienza',
                    grafico: _graficoBattuta(),
                  ),

                  const SizedBox(height: 16),

                  // ==================================================
                  // RICEZIONE
                  // ==================================================

                  _sezioneGrafico(
                    titolo: 'RICEZIONE',
                    sottotitolo:
                        'Positività ed efficienza della ricezione',
                    grafico: _graficoRicezione(),
                  ),

                  const SizedBox(height: 16),

                  // ==================================================
                  // DIFESA
                  // ==================================================

                  _sezioneGrafico(
                    titolo: 'DIFESA',
                    sottotitolo:
                        'Positività ed efficienza della difesa',
                    grafico: _graficoDifesa(),
                  ),

                  const SizedBox(height: 16),

                  // ==================================================
                  // MURO
                  // ==================================================

                  _sezioneGrafico(
                    titolo: 'MURO',
                    sottotitolo:
                        'Percentuale di muri punto ed efficienza',
                    grafico: _graficoMuro(),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }

  // ============================================================
  // CARD DEL GRAFICO
  // ============================================================

  Widget _sezioneGrafico({
    required String titolo,
    required String sottotitolo,
    required Widget grafico,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        18,
        18,
        18,
        20,
      ),
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            titolo,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            sottotitolo,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 20),

          grafico,
        ],
      ),
    );
  }

  // ============================================================
  // ATTACCO
  // ============================================================

  Widget _graficoAttacco() {
    final kill = archivioPartite.map((partita) {
      return AnalizzatoreStatistiche
          .calcolaKillPercentuale(
        partita.attacchi,
      );
    }).toList();

    final efficienza =
        archivioPartite.map((partita) {
      return AnalizzatoreStatistiche
          .calcolaEfficienzaAttacco(
        partita.attacchi,
      );
    }).toList();

    return _graficoDueLinee(
      valori1: kill,
      valori2: efficienza,
      nome1: 'Kill',
      nome2: 'Efficienza',
      minimoY: -50,
      massimoY: 100,
    );
  }

  // ============================================================
  // BATTUTA
  // ============================================================

  Widget _graficoBattuta() {
    final ace = archivioPartite.map((partita) {
      return AnalizzatoreStatistiche
          .calcolaAcePercentuale(
        partita.battuta,
      );
    }).toList();

    final efficienza =
        archivioPartite.map((partita) {
      return AnalizzatoreStatistiche
          .calcolaEfficienzaBattuta(
        partita.battuta,
      );
    }).toList();

    return _graficoDueLinee(
      valori1: ace,
      valori2: efficienza,
      nome1: 'Ace',
      nome2: 'Efficienza',
      minimoY: -50,
      massimoY: 50,
    );
  }

  // ============================================================
  // RICEZIONE
  // ============================================================

  Widget _graficoRicezione() {
    final positivita =
        archivioPartite.map((partita) {
      return AnalizzatoreStatistiche
          .calcolaPositivitaRicezione(
        partita.ricezione,
      );
    }).toList();

    final efficienza =
        archivioPartite.map((partita) {
      return AnalizzatoreStatistiche
          .calcolaEfficienzaRicezione(
        partita.ricezione,
      );
    }).toList();

    return _graficoDueLinee(
      valori1: positivita,
      valori2: efficienza,
      nome1: 'Positività',
      nome2: 'Efficienza',
      minimoY: -50,
      massimoY: 100,
    );
  }

  // ============================================================
  // DIFESA
  // ============================================================

  Widget _graficoDifesa() {
    final positivita =
        archivioPartite.map((partita) {
      return AnalizzatoreStatistiche
          .calcolaPositivitaDifesa(
        partita.difesa,
      );
    }).toList();

    final efficienza =
        archivioPartite.map((partita) {
      return AnalizzatoreStatistiche
          .calcolaEfficienzaDifesa(
        partita.difesa,
      );
    }).toList();

    return _graficoDueLinee(
      valori1: positivita,
      valori2: efficienza,
      nome1: 'Positività',
      nome2: 'Efficienza',
      minimoY: -50,
      massimoY: 100,
    );
  }

  // ============================================================
  // MURO
  // ============================================================

  Widget _graficoMuro() {
    final block = archivioPartite.map((partita) {
      return AnalizzatoreStatistiche
          .calcolaBlockPercentuale(
        partita.muro,
      );
    }).toList();

    final efficienza =
        archivioPartite.map((partita) {
      return AnalizzatoreStatistiche
          .calcolaEfficienzaMuro(
        partita.muro,
      );
    }).toList();

    return _graficoDueLinee(
      valori1: block,
      valori2: efficienza,
      nome1: 'Muro punto',
      nome2: 'Efficienza',
      minimoY: -50,
      massimoY: 100,
    );
  }

  // ============================================================
  // GRAFICO GENERICO A DUE LINEE
  // ============================================================

  Widget _graficoDueLinee({
    required List<double> valori1,
    required List<double> valori2,
    required String nome1,
    required String nome2,
    required double minimoY,
    required double massimoY,
  }) {
    if (archivioPartite.length < 2) {
      return SizedBox(
        height: 250,
        child: Center(
          child: Text(
            'Servono almeno 2 partite per vedere l\'andamento.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ),
      );
    }

    final spots1 = List.generate(
      valori1.length,
      (index) => FlSpot(
        index.toDouble(),
        valori1[index],
      ),
    );

    final spots2 = List.generate(
      valori2.length,
      (index) => FlSpot(
        index.toDouble(),
        valori2[index],
      ),
    );

    return Column(
      children: [
        // ========================================================
        // GRAFICO
        // ========================================================

        SizedBox(
          height: 260,
          width: double.infinity,

          // IMPORTANTE:
          // impedisce al grafico di uscire dalla card
          child: ClipRect(
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX:
                    (archivioPartite.length - 1)
                        .toDouble(),

                minY: minimoY,
                maxY: massimoY,

                // ==================================================
                // GRIGLIA
                // ==================================================

                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine:
                      (value) {
                    return FlLine(
                      color: value == 0
                          ? Colors.grey
                              .withOpacity(0.45)
                          : Colors.grey
                              .withOpacity(0.15),
                      strokeWidth:
                          value == 0 ? 1.5 : 1,
                    );
                  },
                ),

                // ==================================================
                // ASSI
                // ==================================================

                titlesData: FlTitlesData(
                  topTitles:
                      const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),

                  rightTitles:
                      const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 42,
                      interval: 20,
                      getTitlesWidget:
                          (value, meta) {
                        return Text(
                          '${value.toInt()}%',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors
                                .grey.shade600,
                          ),
                        );
                      },
                    ),
                  ),

                  bottomTitles:
                      AxisTitles(
                    sideTitles:
                        SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget:
                          (value, meta) {
                        final indice =
                            value.toInt();

                        if (indice < 0 ||
                            indice >=
                                archivioPartite
                                    .length) {
                          return const SizedBox();
                        }

                        return Text(
                          '${indice + 1}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors
                                .grey.shade600,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // ==================================================
                // BORDO
                // ==================================================

                borderData:
                    FlBorderData(
                  show: false,
                ),

                // ==================================================
                // TOUCH
                // ==================================================

                lineTouchData:
                    LineTouchData(
                  enabled: true,
                  touchSpotThreshold: 20,
                  handleBuiltInTouches: true,

                  touchTooltipData:
                      LineTouchTooltipData(
                    fitInsideHorizontally:
                        true,
                    fitInsideVertically:
                        true,
                    maxContentWidth: 180,
                    tooltipPadding:
                        const EdgeInsets.all(
                      10,
                    ),

                    getTooltipItems:
                        (touchedSpots) {
                      if (touchedSpots
                          .isEmpty) {
                        return [];
                      }

                      final indice =
                          touchedSpots
                              .first.x
                              .toInt();

                      if (indice < 0 ||
                          indice >=
                              archivioPartite
                                  .length) {
                        return [];
                      }

                      final partita =
                          archivioPartite[
                              indice];

                      final risultati =
                          <LineTooltipItem?>[];

                      // VS + DATA
                      risultati.add(
                        LineTooltipItem(
                          'VS ${partita.avversario}\n',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  '${partita.data.day.toString().padLeft(2, '0')}/'
                                  '${partita.data.month.toString().padLeft(2, '0')}/'
                                  '${partita.data.year}',
                              style:
                                  const TextStyle(
                                color:
                                    Colors.white70,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      );

                      // VALORI
                      for (final spot
                          in touchedSpots) {
                        final nome =
                            spot.barIndex ==
                                    0
                                ? nome1
                                : nome2;

                        risultati.add(
                          LineTooltipItem(
                            '$nome: '
                            '${spot.y.toStringAsFixed(1)}%',
                            TextStyle(
                              color:
                                  spot.bar.color ??
                                      Colors.white,
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }

                      return risultati;
                    },
                  ),
                ),

                // ==================================================
                // LINEE
                // ==================================================

                lineBarsData: [
                  LineChartBarData(
                    spots: spots1,
                    isCurved: true,
                    barWidth: 3,
                    color: Colors.blue,

                    dotData:
                        const FlDotData(
                      show: true,
                    ),

                    belowBarData:
                        BarAreaData(
                      show: false,
                    ),
                  ),

                  LineChartBarData(
                    spots: spots2,
                    isCurved: true,
                    barWidth: 3,
                    color: Colors.orange,

                    dotData:
                        const FlDotData(
                      show: true,
                    ),

                    belowBarData:
                        BarAreaData(
                      show: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // ========================================================
        // LEGENDA
        // ========================================================

        Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            _legenda(
              colore: Colors.blue,
              testo: nome1,
            ),

            const SizedBox(width: 25),

            _legenda(
              colore: Colors.orange,
              testo: nome2,
            ),
          ],
        ),

        const SizedBox(height: 6),

        Text(
          'Tocca un punto per vedere il valore della partita',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // LEGENDA
  // ============================================================

  Widget _legenda({
    required Color colore,
    required String testo,
  }) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: colore,
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 6),

        Text(
          testo,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}