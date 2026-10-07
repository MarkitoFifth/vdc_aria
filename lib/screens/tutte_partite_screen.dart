import 'package:flutter/material.dart';

import '../services/archivio_partite.dart';
import '../services/archivio_stagioni.dart';
import '../dati_inseribili/dati.dart';
import 'dettaglio_partita_screen.dart';

class TuttePartiteScreen extends StatefulWidget {
  const TuttePartiteScreen({
    super.key,
  });

  @override
  State<TuttePartiteScreen> createState() =>
      _TuttePartiteScreenState();
}

class _TuttePartiteScreenState
    extends State<TuttePartiteScreen> {
  Future<void> eliminaPartita(Partita partita) async {
    final bool? conferma = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final bool vinta =
            partita.risultato.toUpperCase() == 'V';

        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Eliminare la partita?',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'VS ${partita.avversario}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${partita.categoria} • '
                '${partita.luogo}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: vinta
                      ? const Color(0xFFEAF6EE)
                      : const Color(0xFFFBECEC),
                  borderRadius:
                      BorderRadius.circular(10),
                ),
                child: Text(
                  vinta ? 'VINTA' : 'PERSA',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: vinta
                        ? const Color(0xFF248A49)
                        : const Color(0xFFC63D3D),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'La partita verrà eliminata anche '
                'dalle statistiche e dai grafici.',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: const Text(
                'Annulla',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor:
                    const Color(0xFF111111),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child: const Text(
                'Elimina',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (conferma != true) {
      return;
    }

    await ArchivioStagioni.eliminaPartita(
      partita,
    );

    if (!mounted) return;

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        content: const Text(
          'Partita eliminata.',
        ),
      ),
    );
  }

  String _dataPartita(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';
  }

  @override
  Widget build(BuildContext context) {
    final List<Partita> partite =
        archivioPartite.reversed.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFF5F5F5),
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 70,
        titleSpacing: 16,

        title: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Partite',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              '${partite.length} partite registrate',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),

      body: partite.isEmpty
          ? const _ArchivioVuoto()
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                28,
              ),
              itemCount: partite.length,
              separatorBuilder:
                  (context, index) =>
                      const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final partita = partite[index];

                final bool vinta =
                    partita.risultato.toUpperCase() ==
                        'V';

                return _PartitaCard(
                  partita: partita,
                  vinta: vinta,
                  data: _dataPartita(
                    partita.data,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DettaglioPartitaScreen(
                          partita: partita,
                        ),
                      ),
                    );
                  },
                  onDelete: () =>
                      eliminaPartita(partita),
                );
              },
            ),
    );
  }
}

class _PartitaCard extends StatelessWidget {
  final Partita partita;
  final bool vinta;
  final String data;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _PartitaCard({
    required this.partita,
    required this.vinta,
    required this.data,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE8E8E8),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: vinta
                      ? const Color(0xFFEAF6EE)
                      : const Color(0xFFFBECEC),
                  borderRadius:
                      BorderRadius.circular(13),
                ),
                child: Icon(
                  vinta
                      ? Icons.check_rounded
                      : Icons.close_rounded,
                  color: vinta
                      ? const Color(0xFF248A49)
                      : const Color(0xFFC63D3D),
                  size: 20,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'vs ${partita.avversario}',
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '${partita.categoria} • '
                      '${partita.luogo}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      data,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  Text(
                    vinta ? 'V' : 'P',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: vinta
                          ? const Color(0xFF248A49)
                          : const Color(0xFFC63D3D),
                    ),
                  ),
                  const SizedBox(height: 2),
                  IconButton(
                    visualDensity:
                        VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                    tooltip: 'Elimina',
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      size: 19,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 2),

              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 13,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArchivioVuoto extends StatelessWidget {
  const _ArchivioVuoto();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE8E8E8),
                ),
              ),
              child: const Icon(
                Icons.sports_volleyball_rounded,
                color: Colors.black54,
                size: 27,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Nessuna partita',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Le partite che registrerai '
              'appariranno qui.',
              textAlign: TextAlign.center,
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
}