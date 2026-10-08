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
  // =========================================================
  // ELIMINA PARTITA
  // =========================================================

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

  // =========================================================
  // DATA
  // =========================================================

  String _dataPartita(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final List<Partita> partite =
        archivioPartite.reversed.toList();

    final int vinte = partite
        .where(
          (partita) =>
              partita.risultato.toUpperCase() == 'V',
        )
        .length;

    final int perse = partite.length - vinte;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F5F5),

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFF5F5F5),

        elevation: 0,

        scrolledUnderElevation: 0,

        toolbarHeight: 76,

        titleSpacing: 16,

        title: Row(
          children: [
            // -------------------------------------------------
            // TITOLO
            // -------------------------------------------------

            const Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Partite',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight:
                          FontWeight.w800,
                      letterSpacing: -0.7,
                    ),
                  ),

                  SizedBox(height: 2),

                  Text(
                    'Storico delle tue partite',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // -------------------------------------------------
            // NUMERO PARTITE
            // -------------------------------------------------

            Container(
              height: 40,

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 12,
              ),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(13),
              ),

              child: Row(
                mainAxisSize:
                    MainAxisSize.min,
                children: [
                  const Icon(
                    Icons
                        .sports_volleyball_rounded,
                    size: 17,
                    color: Colors.black54,
                  ),

                  const SizedBox(width: 7),

                  Text(
                    '${partite.length}',
                    style:
                        const TextStyle(
                      fontSize: 13,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // =====================================================
      // BODY
      // =====================================================

      body: partite.isEmpty
          ? const _ArchivioVuoto()
          : ListView(
              padding:
                  const EdgeInsets.fromLTRB(
                16,
                4,
                16,
                28,
              ),

              children: [
                // =============================================
                // RIEPILOGO
                // =============================================

                _RiepilogoPartite(
                  totale: partite.length,
                  vinte: vinte,
                  perse: perse,
                ),

                const SizedBox(height: 16),

                // =============================================
                // TITOLO SEZIONE
                // =============================================

                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'TUTTE LE PARTITE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight:
                              FontWeight.w800,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),

                    Text(
                      'Più recenti',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight:
                            FontWeight.w600,
                        color:
                            Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 9),

                // =============================================
                // LISTA
                // =============================================

                ...partite.map(
                  (partita) {
                    final bool vinta =
                        partita.risultato
                                .toUpperCase() ==
                            'V';

                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 9,
                      ),
                      child: _PartitaCard(
                        partita: partita,
                        vinta: vinta,
                        data: _dataPartita(
                          partita.data,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      DettaglioPartitaScreen(
                                partita:
                                    partita,
                              ),
                            ),
                          );
                        },
                        onDelete: () =>
                            eliminaPartita(
                          partita,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}

// =============================================================
// RIEPILOGO PARTITE
// =============================================================

class _RiepilogoPartite extends StatelessWidget {
  final int totale;
  final int vinte;
  final int perse;

  const _RiepilogoPartite({
    required this.totale,
    required this.vinte,
    required this.perse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEAEAEA),
        ),
      ),

      child: Row(
        children: [
          // ===================================================
          // TOTALE
          // ===================================================

          Expanded(
            child: _StatBox(
              value: '$totale',
              label: 'PARTITE',
              color: Colors.black,
            ),
          ),

          const SizedBox(width: 8),

          // ===================================================
          // VINTE
          // ===================================================

          Expanded(
            child: _StatBox(
              value: '$vinte',
              label: 'VINTE',
              color:
                  const Color(0xFF248A49),
            ),
          ),

          const SizedBox(width: 8),

          // ===================================================
          // PERSE
          // ===================================================

          Expanded(
            child: _StatBox(
              value: '$perse',
              label: 'PERSE',
              color:
                  const Color(0xFFC63D3D),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// BOX STATISTICA
// =============================================================

class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatBox({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,

      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius:
            BorderRadius.circular(14),
      ),

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.w900,
              color: color,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            label,
            style: TextStyle(
              fontSize: 8.5,
              fontWeight:
                  FontWeight.w800,
              letterSpacing: 0.8,
              color:
                  Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// CARD PARTITA
// =============================================================

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

      borderRadius:
          BorderRadius.circular(18),

      child: InkWell(
        onTap: onTap,

        borderRadius:
            BorderRadius.circular(18),

        child: Container(
          padding: const EdgeInsets.all(14),

          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(18),

            border: Border.all(
              color:
                  const Color(0xFFE8E8E8),
            ),
          ),

          child: Row(
            children: [
              // =================================================
              // RISULTATO
              // =================================================

              Container(
                width: 43,
                height: 52,

                decoration: BoxDecoration(
                  color: vinta
                      ? const Color(
                          0xFFEAF6EE,
                        )
                      : const Color(
                          0xFFFBECEC,
                        ),

                  borderRadius:
                      BorderRadius.circular(
                    13,
                  ),
                ),

                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Icon(
                      vinta
                          ? Icons.check_rounded
                          : Icons.close_rounded,

                      size: 18,

                      color: vinta
                          ? const Color(
                              0xFF248A49,
                            )
                          : const Color(
                              0xFFC63D3D,
                            ),
                    ),

                    const SizedBox(height: 1),

                    Text(
                      vinta ? 'V' : 'P',

                      style: TextStyle(
                        fontSize: 10,
                        fontWeight:
                            FontWeight.w900,
                        color: vinta
                            ? const Color(
                                0xFF248A49,
                              )
                            : const Color(
                                0xFFC63D3D,
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // =================================================
              // INFO PARTITA
              // =================================================

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

                      style:
                          const TextStyle(
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w800,
                        letterSpacing: -0.1,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            partita.categoria,
                            maxLines: 1,
                            overflow:
                                TextOverflow
                                    .ellipsis,
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight:
                                  FontWeight.w600,
                              color: Colors
                                  .grey
                                  .shade700,
                            ),
                          ),
                        ),

                        Padding(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 5,
                          ),
                          child: Text(
                            '•',
                            style: TextStyle(
                              color: Colors
                                  .grey
                                  .shade400,
                            ),
                          ),
                        ),

                        Flexible(
                          child: Text(
                            partita.luogo,
                            maxLines: 1,
                            overflow:
                                TextOverflow
                                    .ellipsis,
                            style: TextStyle(
                              fontSize: 10.5,
                              color: Colors
                                  .grey
                                  .shade600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 3),

                    Text(
                      data,
                      style: TextStyle(
                        fontSize: 9.5,
                        color: Colors
                            .grey
                            .shade500,
                        fontWeight:
                            FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // =================================================
              // AZIONI
              // =================================================

              Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  IconButton(
                    visualDensity:
                        VisualDensity.compact,

                    padding:
                        EdgeInsets.zero,

                    constraints:
                        const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),

                    tooltip: 'Elimina',

                    onPressed:
                        onDelete,

                    icon: Icon(
                      Icons
                          .more_horiz_rounded,
                      size: 20,
                      color: Colors
                          .grey
                          .shade500,
                    ),
                  ),

                  const Icon(
                    Icons
                        .arrow_forward_ios_rounded,
                    size: 11,
                    color: Colors.black38,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================
// ARCHIVIO VUOTO
// =============================================================

class _ArchivioVuoto extends StatelessWidget {
  const _ArchivioVuoto();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(30),

        child: Column(
          mainAxisSize:
              MainAxisSize.min,

          children: [
            Container(
              width: 64,
              height: 64,

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  19,
                ),

                border: Border.all(
                  color:
                      const Color(0xFFE8E8E8),
                ),
              ),

              child: const Icon(
                Icons
                    .sports_volleyball_rounded,
                color: Colors.black54,
                size: 29,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Nessuna partita',
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Le partite che registrerai '
              'appariranno qui.',
              textAlign:
                  TextAlign.center,

              style: TextStyle(
                fontSize: 12,
                color:
                    Colors.grey.shade600,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}