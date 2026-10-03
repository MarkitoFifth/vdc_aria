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

            const SizedBox(height: 4),

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

            if (partite.isEmpty)
              Container(
                height: 150,
                alignment: Alignment.center,
                child: Text(
                  'Inserisci delle partite per vedere il grafico',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              )
            else
              SizedBox(
                height: 170,
                child: _MiniGrafico(
                  valori: valori,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MiniGrafico extends StatelessWidget {
  final List<double> valori;

  const _MiniGrafico({
    required this.valori,
  });

  @override
  Widget build(BuildContext context) {
    if (valori.length == 1) {
      return Center(
        child: Text(
          '${valori.first.toStringAsFixed(1)}%',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return CustomPaint(
      painter: _GraficoPainter(
        valori: valori,
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _GraficoPainter extends CustomPainter {
  final List<double> valori;

  _GraficoPainter({
    required this.valori,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (valori.isEmpty) return;

    final paintLinea = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintPunto = Paint()
      ..style = PaintingStyle.fill;

    final paintGriglia = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final double maxValore = 50;
    final double minValore = -10;

    final double graphHeight = size.height - 25;
    final double graphWidth = size.width - 10;

    double yDaValore(double valore) {
      final percentuale =
          (valore - minValore) /
          (maxValore - minValore);

      return graphHeight -
          (percentuale * graphHeight);
    }

    // Griglia
    for (int i = 0; i <= 4; i++) {
      final y = (graphHeight / 4) * i;

      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paintGriglia,
      );
    }

    // Linea
    final path = Path();

    for (int i = 0; i < valori.length; i++) {
      final double x;

      if (valori.length == 1) {
        x = graphWidth / 2;
      } else {
        x = (graphWidth / (valori.length - 1)) * i;
      }

      final y = yDaValore(
        valori[i].clamp(minValore, maxValore),
      );

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paintLinea);

    // Punti
    for (int i = 0; i < valori.length; i++) {
      final double x;

      if (valori.length == 1) {
        x = graphWidth / 2;
      } else {
        x = (graphWidth / (valori.length - 1)) * i;
      }

      final y = yDaValore(
        valori[i].clamp(minValore, maxValore),
      );

      canvas.drawCircle(
        Offset(x, y),
        4,
        paintPunto,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GraficoPainter oldDelegate) {
    return oldDelegate.valori != valori;
  }
}