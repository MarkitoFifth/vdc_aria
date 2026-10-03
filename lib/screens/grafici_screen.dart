import 'package:flutter/material.dart';

import '../services/archivio_partite.dart';
import '../services/analizzatore_statistiche.dart';

class GraficiScreen extends StatelessWidget {
  const GraficiScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final partite = archivioPartite;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Andamento statistiche'),
      ),

      body: partite.isEmpty
          ? const Center(
              child: Text(
                'Inserisci delle partite per visualizzare i grafici.',
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ANDAMENTO STAGIONALE',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Ogni punto rappresenta una partita.',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _GraficoSezione(
                    titolo: 'Attacco',
                    sottotitolo:
                        'Kill% e efficienza attacco',
                    valori: [
                      _SerieGrafico(
                        nome: 'Kill%',
                        valori: partite.map(
                          (partita) =>
                              AnalizzatoreStatistiche
                                  .calcolaKillPercentuale(
                            partita.attacchi,
                          ),
                        ).toList(),
                      ),
                      _SerieGrafico(
                        nome: 'Efficienza',
                        valori: partite.map(
                          (partita) =>
                              AnalizzatoreStatistiche
                                  .calcolaEfficienzaAttacco(
                            partita.attacchi,
                          ),
                        ).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _GraficoSezione(
                    titolo: 'Battuta',
                    sottotitolo:
                        'Ace% e efficienza battuta',
                    valori: [
                      _SerieGrafico(
                        nome: 'Ace%',
                        valori: partite.map(
                          (partita) =>
                              AnalizzatoreStatistiche
                                  .calcolaAcePercentuale(
                            partita.battuta,
                          ),
                        ).toList(),
                      ),
                      _SerieGrafico(
                        nome: 'Efficienza',
                        valori: partite.map(
                          (partita) =>
                              AnalizzatoreStatistiche
                                  .calcolaEfficienzaBattuta(
                            partita.battuta,
                          ),
                        ).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _GraficoSezione(
                    titolo: 'Ricezione',
                    sottotitolo:
                        'Positività e efficienza ricezione',
                    valori: [
                      _SerieGrafico(
                        nome: 'Positività',
                        valori: partite.map(
                          (partita) =>
                              AnalizzatoreStatistiche
                                  .calcolaPositivitaRicezione(
                            partita.ricezione,
                          ),
                        ).toList(),
                      ),
                      _SerieGrafico(
                        nome: 'Efficienza',
                        valori: partite.map(
                          (partita) =>
                              AnalizzatoreStatistiche
                                  .calcolaEfficienzaRicezione(
                            partita.ricezione,
                          ),
                        ).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _GraficoSezione(
                    titolo: 'Difesa',
                    sottotitolo:
                        'Positività e efficienza difesa',
                    valori: [
                      _SerieGrafico(
                        nome: 'Positività',
                        valori: partite.map(
                          (partita) =>
                              AnalizzatoreStatistiche
                                  .calcolaPositivitaDifesa(
                            partita.difesa,
                          ),
                        ).toList(),
                      ),
                      _SerieGrafico(
                        nome: 'Efficienza',
                        valori: partite.map(
                          (partita) =>
                              AnalizzatoreStatistiche
                                  .calcolaEfficienzaDifesa(
                            partita.difesa,
                          ),
                        ).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _GraficoSezione(
                    titolo: 'Muro',
                    sottotitolo:
                        'Percentuale muri punto',
                    valori: [
                      _SerieGrafico(
                        nome: 'Muri punto',
                        valori: partite.map(
                          (partita) =>
                              AnalizzatoreStatistiche
                                  .calcolaBlockPercentuale(
                            partita.muro,
                          ),
                        ).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}

class _SerieGrafico {
  final String nome;
  final List<double> valori;

  const _SerieGrafico({
    required this.nome,
    required this.valori,
  });
}

class _GraficoSezione extends StatelessWidget {
  final String titolo;
  final String sottotitolo;
  final List<_SerieGrafico> valori;

  const _GraficoSezione({
    required this.titolo,
    required this.sottotitolo,
    required this.valori,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            titolo,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            sottotitolo,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 18),

          SizedBox(
            height: 210,
            child: CustomPaint(
              painter: _MultiGraficoPainter(
                serie: valori,
              ),
              child: const SizedBox.expand(),
            ),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 18,
            runSpacing: 8,
            children: valori.map(
              (serie) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _coloreSerie(
                          valori.indexOf(serie),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      serie.nome,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Color _coloreSerie(int indice) {
    const colori = [
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.purple,
    ];

    return colori[indice % colori.length];
  }
}

class _MultiGraficoPainter extends CustomPainter {
  final List<_SerieGrafico> serie;

  _MultiGraficoPainter({
    required this.serie,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (serie.isEmpty) return;

    final double graphWidth = size.width - 10;
    final double graphHeight = size.height - 20;

    const double minValore = -10;
    const double maxValore = 100;

    double yDaValore(double valore) {
      final normalizzato =
          (valore - minValore) /
          (maxValore - minValore);

      return graphHeight -
          (normalizzato * graphHeight);
    }

    // Griglia
    final paintGriglia = Paint()
      ..color = Colors.grey.withOpacity(0.15)
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
      final y =
          (graphHeight / 4) * i;

      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paintGriglia,
      );
    }

    const colori = [
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.purple,
    ];

    for (int serieIndex = 0;
        serieIndex < serie.length;
        serieIndex++) {
      final valori = serie[serieIndex].valori;

      if (valori.isEmpty) continue;

      final paintLinea = Paint()
        ..color =
            colori[serieIndex % colori.length]
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final paintPunto = Paint()
        ..color =
            colori[serieIndex % colori.length]
        ..style = PaintingStyle.fill;

      final path = Path();

      for (int i = 0; i < valori.length; i++) {
        final double x;

        if (valori.length == 1) {
          x = graphWidth / 2;
        } else {
          x =
              (graphWidth / (valori.length - 1)) *
                  i;
        }

        final y = yDaValore(
          valori[i].clamp(
            minValore,
            maxValore,
          ),
        );

        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      canvas.drawPath(
        path,
        paintLinea,
      );

      for (int i = 0; i < valori.length; i++) {
        final double x;

        if (valori.length == 1) {
          x = graphWidth / 2;
        } else {
          x =
              (graphWidth / (valori.length - 1)) *
                  i;
        }

        final y = yDaValore(
          valori[i].clamp(
            minValore,
            maxValore,
          ),
        );

        canvas.drawCircle(
          Offset(x, y),
          4,
          paintPunto,
        );
      }
    }
  }

  @override
  bool shouldRepaint(
    covariant _MultiGraficoPainter oldDelegate,
  ) {
    return true;
  }
}