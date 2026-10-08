import 'package:flutter/material.dart';

enum TipoDettaglio {
  punti,
  errori,
}

class DettaglioPuntiErroriScreen extends StatelessWidget {
  final TipoDettaglio tipo;
  final int totale;
  final Map<String, int> dettagli;

  const DettaglioPuntiErroriScreen({
    super.key,
    required this.tipo,
    required this.totale,
    required this.dettagli,
  });

  @override
  Widget build(BuildContext context) {
    final bool punti = tipo == TipoDettaglio.punti;

    final String titolo =
        punti ? 'Dettaglio punti' : 'Dettaglio errori';

    final String sottotitolo =
        punti ? 'Da dove arrivano i tuoi punti' : 'Dove sono stati commessi gli errori';

    final IconData icona =
        punti
            ? Icons.add_circle_outline_rounded
            : Icons.warning_amber_rounded;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          titolo,
          style: const TextStyle(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====================================================
            // TOTALE
            // ====================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      icona,
                      color: Colors.white,
                      size: 23,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$totale',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          height: 1,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        punti ? 'PUNTI TOTALI' : 'ERRORI TOTALI',
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            Text(
              sottotitolo.toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.1,
              ),
            ),

            const SizedBox(height: 10),

            // ====================================================
            // DETTAGLI
            // ====================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE8E8E8),
                ),
              ),
              child: Column(
                children: dettagli.entries.map((entry) {
                  final double percentuale =
                      totale == 0
                          ? 0
                          : (entry.value / totale) * 100;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: _VoceDettaglio(
                      titolo: entry.key,
                      valore: entry.value,
                      percentuale: percentuale,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VoceDettaglio extends StatelessWidget {
  final String titolo;
  final int valore;
  final double percentuale;

  const _VoceDettaglio({
    required this.titolo,
    required this.valore,
    required this.percentuale,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(11),
          ),
          alignment: Alignment.center,
          child: Text(
            '$valore',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titolo,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: (percentuale / 100).clamp(0.0, 1.0),
                  minHeight: 5,
                  backgroundColor: const Color(0xFFEDEDED),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF111111),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        SizedBox(
          width: 50,
          child: Text(
            '${percentuale.toStringAsFixed(1)}%',
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}