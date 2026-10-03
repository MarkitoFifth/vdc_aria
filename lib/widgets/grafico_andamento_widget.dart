import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../services/archivio_partite.dart';
import '../services/analizzatore_statistiche.dart';
import '../screens/grafici_screen.dart';

class GraficoAndamentoWidget extends StatelessWidget {
  const GraficoAndamentoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final partite = archivioPartite;

    final valori = partite.map((partita) {
      return AnalizzatoreStatistiche.calcolaEfficienzaAttacco(
        partita.attacchi,
      );
    }).toList();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GraficiScreen(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================================================
            // HEADER
            // ==================================================

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'ANDAMENTO',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Text(
                  'Vedi grafici →',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

            const Text(
              'Efficienza attacco',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              'Andamento nelle ultime partite',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 18),

            // ==================================================
            // NESSUNA PARTITA
            // ==================================================

            if (partite.isEmpty)
              SizedBox(
                height: 150,
                child: Center(
                  child: Text(
                    'Inserisci delle partite per vedere il grafico',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              )

            // ==================================================
            // UNA SOLA PARTITA
            // ==================================================

            else if (partite.length == 1)
              SizedBox(
                height: 150,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${valori.first.toStringAsFixed(1)}%',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Efficienza vs ${partite.first.avversario}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              )

            // ==================================================
            // GRAFICO
            // ==================================================

            else
              SizedBox(
                height: 170,
                width: double.infinity,
                child: ClipRect(
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: (partite.length - 1).toDouble(),

                      // Range verticale sicuro
                      minY: -50,
                      maxY: 50,

                      // ==================================================
                      // GRIGLIA
                      // ==================================================

                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 20,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: value == 0
                                ? Colors.grey.withOpacity(0.4)
                                : Colors.grey.withOpacity(0.12),
                            strokeWidth:
                                value == 0 ? 1.5 : 1,
                          );
                        },
                      ),

                      // ==================================================
                      // ASSI
                      // ==================================================

                      titlesData: const FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                      ),

                      // ==================================================
                      // BORDO
                      // ==================================================

                      borderData: FlBorderData(
                        show: false,
                      ),

                      // ==================================================
                      // TOUCH
                      // ==================================================

                      lineTouchData: LineTouchData(
                        enabled: true,
                        touchSpotThreshold: 20,
                        handleBuiltInTouches: true,

                        touchTooltipData:
                            LineTouchTooltipData(
                          fitInsideHorizontally: true,
                          fitInsideVertically: true,
                          maxContentWidth: 180,
                          tooltipPadding:
                              const EdgeInsets.all(10),

                          getTooltipItems:
                              (touchedSpots) {
                            return touchedSpots.map(
                              (spot) {
                                final indice =
                                    spot.x.toInt();

                                if (indice < 0 ||
                                    indice >=
                                        partite.length) {
                                  return null;
                                }

                                return LineTooltipItem(
                                  'VS ${partite[indice].avversario}\n'
                                  '${spot.y.toStringAsFixed(1)}%',
                                  const TextStyle(
                                    color: Colors.white,
                                    fontWeight:
                                        FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                );
                              },
                            ).toList();
                          },
                        ),
                      ),

                      // ==================================================
                      // LINEA
                      // ==================================================

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
                          barWidth: 3,
                          color: Colors.blue,

                          dotData: const FlDotData(
                            show: true,
                          ),

                          belowBarData:
                              BarAreaData(
                            show: true,
                            color: Colors.blue
                                .withOpacity(0.08),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 10),

            // ==================================================
            // FOOTER
            // ==================================================

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Tocca per analizzare →',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}