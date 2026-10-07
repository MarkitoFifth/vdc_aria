import 'package:flutter/material.dart';

import '../services/archivio_stagioni.dart';

class SelezioneStagioneScreen extends StatefulWidget {
  const SelezioneStagioneScreen({
    super.key,
  });

  @override
  State<SelezioneStagioneScreen> createState() =>
      _SelezioneStagioneScreenState();
}

class _SelezioneStagioneScreenState
    extends State<SelezioneStagioneScreen> {
  Future<void> creaNuovaStagione() async {
    final controller = TextEditingController();

    String? nome;

    try {
      nome = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (sheetContext) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(
                sheetContext,
              ).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                20,
                12,
                20,
                24,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 38,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8D8D8),
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'Nuova stagione',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Inserisci il nome della stagione.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 18),

                  TextField(
                    controller: controller,
                    autofocus: true,
                    textCapitalization:
                        TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: 'Es. 2026/27',
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      prefixIcon: const Icon(
                        Icons.calendar_today_outlined,
                        size: 19,
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Color(0xFF111111),
                          width: 1,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF111111),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        final valore =
                            controller.text.trim();

                        if (valore.isEmpty) {
                          ScaffoldMessenger.of(
                            sheetContext,
                          ).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Inserisci il nome della stagione.',
                              ),
                            ),
                          );
                          return;
                        }

                        // Chiudiamo SOLO il bottom sheet
                        // e restituiamo il nome inserito.
                        Navigator.of(sheetContext).pop(
                          valore,
                        );
                      },
                      child: const Text(
                        'Crea stagione',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      controller.dispose();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          content: Text(
            'Errore nella apertura della finestra: $e',
          ),
        ),
      );

      return;
    }

    controller.dispose();

    if (!mounted || nome == null) {
      return;
    }

    try {
      // Il bottom sheet è stato chiuso correttamente.
      // Ora proviamo a creare la stagione nel database.
      await ArchivioStagioni.creaStagione(nome!);

      if (!mounted) return;

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          content: Text(
            'Stagione "$nome" creata.',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          duration: const Duration(seconds: 4),
          content: Text(
            'Errore nella creazione della stagione:\n'
            '${e.toString().replaceFirst(
              'Exception: ',
              '',
            )}',
          ),
        ),
      );
    }
  }

  Future<void> eliminaStagione(
    int indice,
  ) async {
    final stagione =
        ArchivioStagioni.stagioni[indice];

    final bool? conferma =
        await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(22),
          ),
          title: const Text(
            'Eliminare la stagione?',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            'La stagione "${stagione.nome}" '
            'e tutte le partite contenute '
            'verranno eliminate.',
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
                ),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor:
                    const Color(0xFF111111),
              ),
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child: const Text(
                'Elimina',
              ),
            ),
          ],
        );
      },
    );

    if (conferma != true) {
      return;
    }

    try {
      await ArchivioStagioni.eliminaStagione(
        indice,
      );

      if (!mounted) return;

      setState(() {});

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          behavior:
              SnackBarBehavior.floating,
          content: Text(
            'Stagione eliminata.',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          behavior:
              SnackBarBehavior.floating,
          content: Text(
            e.toString().replaceFirst(
              'Exception: ',
              '',
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final stagioni =
        ArchivioStagioni.stagioni;

    final indiceAttiva =
        ArchivioStagioni
            .indiceStagioneAttiva;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFF5F5F5),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Stagioni',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          16,
          8,
          16,
          120,
        ),
        itemCount: stagioni.length,
        separatorBuilder:
            (context, index) =>
                const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final stagione = stagioni[index];
          final bool attiva =
              index == indiceAttiva;

          return Material(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(18),
            child: InkWell(
              borderRadius:
                  BorderRadius.circular(18),
              onTap: () {
                ArchivioStagioni
                    .cambiaStagione(index);

                setState(() {});

                Navigator.pop(
                  context,
                  true,
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(18),
                  border: Border.all(
                    color: attiva
                        ? const Color(
                            0xFF111111,
                          )
                        : const Color(
                            0xFFE8E8E8,
                          ),
                    width: attiva ? 1.2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: attiva
                            ? const Color(
                                0xFF111111,
                              )
                            : const Color(
                                0xFFF3F3F3,
                              ),
                        borderRadius:
                            BorderRadius.circular(
                          13,
                        ),
                      ),
                      child: Icon(
                        Icons
                            .calendar_month_rounded,
                        size: 20,
                        color: attiva
                            ? Colors.white
                            : Colors.black54,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Text(
                            stagione.nome,
                            style:
                                const TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.w800,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            '${stagione.partite.length} '
                            '${stagione.partite.length == 1 ? 'partita' : 'partite'}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors
                                  .grey
                                  .shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (attiva)
                      Container(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration:
                            BoxDecoration(
                          color:
                              const Color(
                            0xFFF0F0F0,
                          ),
                          borderRadius:
                              BorderRadius
                                  .circular(
                            8,
                          ),
                        ),
                        child: const Text(
                          'ATTIVA',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight:
                                FontWeight.w800,
                          ),
                        ),
                      ),

                    const SizedBox(width: 4),

                    IconButton(
                      tooltip:
                          'Elimina stagione',
                      onPressed:
                          stagioni.length <= 1
                              ? null
                              : () =>
                                  eliminaStagione(
                                    index,
                                  ),
                      icon: const Icon(
                        Icons
                            .delete_outline_rounded,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      bottomNavigationBar:
          SafeArea(
        minimum:
            const EdgeInsets.fromLTRB(
          16,
          8,
          16,
          16,
        ),
        child: SizedBox(
          height: 54,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor:
                  const Color(0xFF111111),
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(16),
              ),
            ),
            onPressed:
                creaNuovaStagione,
            icon: const Icon(
              Icons.add_rounded,
              size: 20,
            ),
            label: const Text(
              'Nuova stagione',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}