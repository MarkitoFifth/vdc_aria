import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../services/archivio_partite.dart';
import '../services/analizzatore_statistiche.dart';

class GraficiScreen extends StatelessWidget {
  const GraficiScreen({super.key});

  static const Color background = Color(0xFFF5F5F5);
  static const Color card = Colors.white;
  static const Color primary = Color(0xFF111111);
  static const Color secondary = Color(0xFF8A8A8A);
  static const Color grid = Color(0xFFEAEAEA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Analisi andamento',
          style: TextStyle(
            color: primary,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
          ),
        ),
      ),

      body: archivioPartite.isEmpty
          ? const Center(
              child: Text(
                'Non ci sono ancora partite.',
                style: TextStyle(
                  color: secondary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                32,
              ),
              child: Column(
                children: [
                  _sezioneGrafico(
                    titolo: 'ATTACCO',
                    sottotitolo: 'Kill ed efficienza',
                    grafico: _graficoAttacco(),
                  ),

                  const SizedBox(height: 14),

                  _sezioneGrafico(
                    titolo: 'BATTUTA',
                    sottotitolo: 'Ace ed efficienza',
                    grafico: _graficoBattuta(),
                  ),

                  const SizedBox(height: 14),

                  _sezioneGrafico(
                    titolo: 'RICEZIONE',
                    sottotitolo: 'Positività ed efficienza',
                    grafico: _graficoRicezione(),
                  ),

                  const SizedBox(height: 14),

                  _sezioneGrafico(
                    titolo: 'DIFESA',
                    sottotitolo: 'Positività ed efficienza',
                    grafico: _graficoDifesa(),
                  ),

                  const SizedBox(height: 14),

                  _sezioneGrafico(
                    titolo: 'MURO',
                    sottotitolo: 'Muri punto ed efficienza',
                    grafico: _graficoMuro(),
                  ),
                ],
              ),
            ),
    );
  }

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
        16,
      ),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFEDEDED),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      titolo,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.4,
                        color: primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      sottotitolo,
                      style: const TextStyle(
                        fontSize: 13,
                        color: secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.show_chart_rounded,
                  size: 18,
                  color: primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

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
    );
  }

  // ============================================================
  // GRAFICO
  // ============================================================

  Widget _graficoDueLinee({
    required List<double> valori1,
    required List<double> valori2,
    required String nome1,
    required String nome2,
  }) {
    if (archivioPartite.length < 2) {
      return SizedBox(
        height: 220,
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.show_chart_rounded,
                  color: primary,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Servono almeno 2 partite',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'per visualizzare l\'andamento',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
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
        SizedBox(
          height: 240,
          width: double.infinity,
          child: ClipRect(
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX:
                    (archivioPartite.length - 1)
                        .toDouble(),

                minY: -50,
                maxY: 100,

                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 25,
                  getDrawingHorizontalLine:
                      (value) {
                    return FlLine(
                      color: value == 0
                          ? const Color(0xFFD0D0D0)
                          : grid,
                      strokeWidth:
                          value == 0 ? 1.2 : 0.8,
                    );
                  },
                ),

                titlesData: FlTitlesData(
                  topTitles:
                      const AxisTitles(
                    sideTitles:
                        SideTitles(
                      showTitles: false,
                    ),
                  ),
                  rightTitles:
                      const AxisTitles(
                    sideTitles:
                        SideTitles(
                      showTitles: false,
                    ),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles:
                        SideTitles(
                      showTitles: true,
                      reservedSize: 38,
                      interval: 25,
                      getTitlesWidget:
                          (value, meta) {
                        return Text(
                          '${value.toInt()}%',
                          style:
                              const TextStyle(
                            fontSize: 9,
                            color: secondary,
                            fontWeight:
                                FontWeight.w500,
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
                      reservedSize: 25,
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
                          style:
                              const TextStyle(
                            fontSize: 9,
                            color: secondary,
                            fontWeight:
                                FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                borderData:
                    FlBorderData(
                  show: false,
                ),

                lineTouchData:
                    LineTouchData(
                  enabled: true,
                  touchSpotThreshold: 24,

                  getTouchedSpotIndicator:
                      (
                    barData,
                    spotIndexes,
                  ) {
                    return spotIndexes.map(
                      (index) {
                        return TouchedSpotIndicatorData(
                          FlLine(
                            color: const Color(
                              0xFFCCCCCC,
                            ),
                            strokeWidth: 1,
                          ),
                          FlDotData(
                            getDotPainter:
                                (
                              spot,
                              percent,
                              bar,
                              index,
                            ) {
                              return FlDotCirclePainter(
                                radius: 5,
                                color:
                                    Colors.white,
                                strokeWidth: 3,
                                strokeColor:
                                    primary,
                              );
                            },
                          ),
                        );
                      },
                    ).toList();
                  },

                  touchTooltipData:
                      LineTouchTooltipData(
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                    maxContentWidth: 190,
                    tooltipPadding:
                        const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    getTooltipItems:
                        (touchedSpots) {
                      if (touchedSpots.isEmpty) {
                        return [];
                      }

                      final indice =
                          touchedSpots
                              .first
                              .x
                              .toInt();

                      if (indice < 0 ||
                          indice >=
                              archivioPartite
                                  .length) {
                        return [];
                      }

                      final partita =
                          archivioPartite[indice];

                      final items =
                          <LineTooltipItem?>[];

                      items.add(
                        LineTooltipItem(
                          'VS ${partita.avversario}\n',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.w700,
                            fontSize: 12,
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

                      for (final spot
                          in touchedSpots) {
                        final nome =
                            spot.barIndex == 0
                                ? nome1
                                : nome2;

                        items.add(
                          LineTooltipItem(
                            '$nome  '
                            '${spot.y.toStringAsFixed(1)}%',
                            const TextStyle(
                              color: Colors.white,
                              fontWeight:
                                  FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),
                        );
                      }

                      return items;
                    },
                  ),
                ),

                lineBarsData: [
                  LineChartBarData(
                    spots: spots1,
                    isCurved: true,
                    curveSmoothness: 0.25,
                    barWidth: 3,
                    color: primary,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter:
                          (
                        spot,
                        percent,
                        bar,
                        index,
                      ) {
                        return FlDotCirclePainter(
                          radius: 3,
                          color: primary,
                        );
                      },
                    ),
                    belowBarData:
                        BarAreaData(
                      show: true,
                      color: primary.withOpacity(
                        0.045,
                      ),
                    ),
                  ),

                  LineChartBarData(
                    spots: spots2,
                    isCurved: true,
                    curveSmoothness: 0.25,
                    barWidth: 2,
                    color: const Color(
                      0xFF9A9A9A,
                    ),
                    dotData: FlDotData(
                      show: true,
                      getDotPainter:
                          (
                        spot,
                        percent,
                        bar,
                        index,
                      ) {
                        return FlDotCirclePainter(
                          radius: 2.5,
                          color:
                              const Color(
                            0xFF9A9A9A,
                          ),
                        );
                      },
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

        Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            _legenda(
              colore: primary,
              testo: nome1,
              lineaSpessa: true,
            ),
            const SizedBox(width: 24),
            _legenda(
              colore: const Color(0xFF9A9A9A),
              testo: nome2,
              lineaSpessa: false,
            ),
          ],
        ),

        const SizedBox(height: 8),

        Text(
          'Tocca un punto per vedere i dettagli',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _legenda({
    required Color colore,
    required String testo,
    required bool lineaSpessa,
  }) {
    return Row(
      children: [
        Container(
          width: 18,
          height: lineaSpessa ? 3 : 2,
          decoration: BoxDecoration(
            color: colore,
            borderRadius:
                BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 7),
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