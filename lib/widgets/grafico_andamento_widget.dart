import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../screens/grafici_screen.dart';
import '../services/analizzatore_statistiche.dart';
import '../services/archivio_partite.dart';

class GraficoAndamentoWidget extends StatelessWidget {
  const GraficoAndamentoWidget({
    super.key,
  });

  static const Color primary = Color(0xFF111111);
  static const Color secondary = Color(0xFF8A8A8A);

  @override
  Widget build(BuildContext context) {
    final partite = archivioPartite;

    final valori = partite.map((partita) {
      return AnalizzatoreStatistiche
          .calcolaEfficienzaAttacco(
        partita.attacchi,
      );
    }).toList();

    final double media = valori.isEmpty
        ? 0
        : valori.reduce((a, b) => a + b) /
            valori.length;

    final double ultima =
        valori.isEmpty ? 0 : valori.last;

    final double precedente =
        valori.length < 2
            ? 0
            : valori[valori.length - 2];

    final double differenza =
        valori.length < 2
            ? 0
            : ultima - precedente;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const GraficiScreen(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          18,
          18,
          18,
          16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFFEDEDED),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'ANDAMENTO',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Vedi analisi  →',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.end,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Efficienza attacco',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Andamento nelle partite',
                        style: TextStyle(
                          fontSize: 11,
                          color: secondary,
                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                if (partite.isNotEmpty)
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${ultima.toStringAsFixed(1)}%',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                        ),
                      ),
                      if (valori.length >= 2)
                        Row(
                          children: [
                            Icon(
                              differenza >= 0
                                  ? Icons
                                      .trending_up_rounded
                                  : Icons
                                      .trending_down_rounded,
                              size: 13,
                              color: primary,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '${differenza >= 0 ? '+' : ''}'
                              '${differenza.toStringAsFixed(1)}%',
                              style:
                                  const TextStyle(
                                fontSize: 10,
                                fontWeight:
                                    FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
              ],
            ),

            const SizedBox(height: 18),

            if (partite.isEmpty)
              SizedBox(
                height: 145,
                child: Center(
                  child: Text(
                    'Inserisci delle partite per vedere l\'andamento',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              )
            else if (partite.length == 1)
              SizedBox(
                height: 145,
                child: Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text(
                        '${ultima.toStringAsFixed(1)}%',
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'VS ${partite.first.avversario}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: secondary,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SizedBox(
                height: 155,
                width: double.infinity,
                child: ClipRect(
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX:
                          (partite.length - 1)
                              .toDouble(),
                      minY: -50,
                      maxY: 50,

                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 25,
                        getDrawingHorizontalLine:
                            (value) {
                          return FlLine(
                            color: value == 0
                                ? const Color(
                                    0xFFD2D2D2,
                                  )
                                : const Color(
                                    0xFFF0F0F0,
                                  ),
                            strokeWidth:
                                value == 0
                                    ? 1.2
                                    : 0.8,
                          );
                        },
                      ),

                      titlesData:
                          const FlTitlesData(
                        leftTitles:
                            AxisTitles(
                          sideTitles:
                              SideTitles(
                            showTitles: false,
                          ),
                        ),
                        rightTitles:
                            AxisTitles(
                          sideTitles:
                              SideTitles(
                            showTitles: false,
                          ),
                        ),
                        topTitles:
                            AxisTitles(
                          sideTitles:
                              SideTitles(
                            showTitles: false,
                          ),
                        ),
                        bottomTitles:
                            AxisTitles(
                          sideTitles:
                              SideTitles(
                            showTitles: false,
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
                        touchTooltipData:
                            LineTouchTooltipData(
                          fitInsideHorizontally:
                              true,
                          fitInsideVertically:
                              true,
                          tooltipPadding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 12,
                            vertical: 9,
                          ),
                          getTooltipItems:
                              (touchedSpots) {
                            return touchedSpots
                                .map(
                              (spot) {
                                final indice =
                                    spot.x.toInt();

                                if (indice < 0 ||
                                    indice >=
                                        partite
                                            .length) {
                                  return null;
                                }

                                return LineTooltipItem(
                                  'VS ${partite[indice].avversario}\n'
                                  '${spot.y.toStringAsFixed(1)}%',
                                  const TextStyle(
                                    color: Colors.white,
                                    fontWeight:
                                        FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                );
                              },
                            ).toList();
                          },
                        ),
                      ),

                      lineBarsData: [
                        LineChartBarData(
                          spots: List.generate(
                            valori.length,
                            (index) => FlSpot(
                              index.toDouble(),
                              valori[index],
                            ),
                          ),
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
                            color: primary
                                .withOpacity(
                              0.045,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 12),

            Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration:
                      const BoxDecoration(
                    color: primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Media stagione: '
                  '${media.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 10,
                    color: secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Tocca per analizzare →',
                  style: TextStyle(
                    fontSize: 10,
                    color: secondary,
                    fontWeight: FontWeight.w700,
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