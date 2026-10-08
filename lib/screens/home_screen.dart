import 'package:flutter/material.dart';

import '../dati_inseribili/dati.dart';
import '../services/archivio_stagioni.dart';

import '../widgets/ultima_partita_widget.dart';
import '../widgets/ultime_partite_widget.dart';
import '../widgets/medie_statistiche_widget.dart';
import '../widgets/grafico_andamento_widget.dart';

import 'nuova_partita_screen.dart';
import 'selezione_stagione_screen.dart';
import 'dettaglio_partita_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _ricercaController =
      TextEditingController();

  String _ricerca = '';

  // =========================================================
  // SELEZIONE STAGIONE
  // =========================================================

  Future<void> apriSelezioneStagione() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const SelezioneStagioneScreen(),
      ),
    );

    if (!mounted) return;

    setState(() {});
  }

  // =========================================================
  // NUOVA PARTITA
  // =========================================================

  Future<void> apriNuovaPartita() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const NuovaPartitaScreen(),
      ),
    );

    if (!mounted) return;

    // Forza la Home a rileggere i dati aggiornati
    // da ArchivioStagioni.stagioneAttiva.partite.
    setState(() {});
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _ricercaController.dispose();
    super.dispose();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final stagione =
        ArchivioStagioni.stagioneAttiva;

    final numeroPartite =
        stagione.partite.length;

    final String ricerca =
        _ricerca.trim().toLowerCase();

    final List<Partita> risultati =
        ricerca.isEmpty
            ? []
            : stagione.partite
                .where(
                  (partita) => partita.avversario
                      .toLowerCase()
                      .contains(ricerca),
                )
                .toList()
                .reversed
                .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFF5F5F5),

        elevation: 0,

        scrolledUnderElevation: 0,

        toolbarHeight: 64,

        titleSpacing: 16,

        title: Row(
          crossAxisAlignment:
              CrossAxisAlignment.center,

          children: [
            // =================================================
            // PARTITE
            // =================================================

            Container(
              height: 42,

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
                    '$numeroPartite PARTITE',

                    style:
                        const TextStyle(
                      fontSize: 12,
                      fontWeight:
                          FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // =================================================
            // RICERCA
            // =================================================

            Expanded(
              child: SizedBox(
                height: 42,

                child: TextField(
                  controller:
                      _ricercaController,

                  onChanged: (valore) {
                    setState(() {
                      _ricerca = valore;
                    });
                  },

                  textAlignVertical:
                      TextAlignVertical.center,

                  style:
                      const TextStyle(
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w600,
                  ),

                  decoration:
                      InputDecoration(
                    hintText:
                        'Cerca partita...',

                    hintStyle:
                        TextStyle(
                      color:
                          Colors.grey.shade500,
                      fontSize: 12,
                      fontWeight:
                          FontWeight.w500,
                    ),

                    prefixIcon:
                        const Icon(
                      Icons.search_rounded,
                      size: 18,
                      color: Colors.black54,
                    ),

                    suffixIcon:
                        _ricerca.isNotEmpty
                            ? IconButton(
                                tooltip:
                                    'Cancella ricerca',

                                padding:
                                    EdgeInsets.zero,

                                icon:
                                    const Icon(
                                  Icons
                                      .close_rounded,
                                  size: 17,
                                ),

                                onPressed: () {
                                  _ricercaController
                                      .clear();

                                  setState(() {
                                    _ricerca = '';
                                  });
                                },
                              )
                            : null,

                    filled: true,

                    fillColor:
                        Colors.white,

                    contentPadding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 12,
                    ),

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        13,
                      ),
                      borderSide:
                          BorderSide.none,
                    ),

                    enabledBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        13,
                      ),
                      borderSide:
                          BorderSide.none,
                    ),

                    focusedBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        13,
                      ),
                      borderSide:
                          const BorderSide(
                        color:
                            Color(0xFF111111),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            // =================================================
            // STAGIONE
            // =================================================

            SizedBox(
              height: 42,

              child: TextButton.icon(
                onPressed:
                    apriSelezioneStagione,

                icon: const Icon(
                  Icons
                      .keyboard_arrow_down_rounded,
                  size: 18,
                ),

                label: Text(
                  stagione.nome,

                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.w700,
                    fontSize: 12,
                  ),
                ),

                style:
                    TextButton.styleFrom(
                  foregroundColor:
                      Colors.black,

                  backgroundColor:
                      Colors.white,

                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 11,
                  ),

                  minimumSize:
                      Size.zero,

                  tapTargetSize:
                      MaterialTapTargetSize
                          .shrinkWrap,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      13,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // =====================================================
      // BODY
      // =====================================================

      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding:
                  const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                28,
              ),

              child: Column(
                children: [
                  // =================================================
                  // ULTIMA PARTITA
                  // =================================================

                  // IMPORTANTE:
                  // niente "const" perché questo widget
                  // dipende dalle partite aggiornate.

                  UltimaPartitaWidget(),

                  // Spazio ridotto da 14 a 8
                  const SizedBox(height: 8),

                  // =================================================
                  // ULTIME PARTITE + MEDIE
                  // =================================================

                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.stretch,

                      children: [
                        Expanded(
                          flex: 45,

                          child:
                              UltimePartiteWidget(),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          flex: 55,

                          child:
                              MedieStatisticheWidget(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // =================================================
                  // GRAFICO
                  // =================================================

                  GraficoAndamentoWidget(),

                  const SizedBox(height: 18),

                  // =================================================
                  // NUOVA PARTITA
                  // =================================================

                  GestureDetector(
                    onTap:
                        apriNuovaPartita,

                    child: Container(
                      width:
                          double.infinity,

                      height: 58,

                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 16,
                      ),

                      decoration:
                          BoxDecoration(
                        color:
                            const Color(
                          0xFF111111,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),
                      ),

                      child: Row(
                        children: [
                          Container(
                            width: 34,
                            height: 34,

                            decoration:
                                BoxDecoration(
                              color: Colors
                                  .white
                                  .withOpacity(
                                0.12,
                              ),

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                11,
                              ),
                            ),

                            child:
                                const Icon(
                              Icons.add_rounded,
                              color:
                                  Colors.white,
                              size: 21,
                            ),
                          ),

                          const SizedBox(
                            width: 12,
                          ),

                          const Expanded(
                            child: Text(
                              'Nuova partita',

                              style:
                                  TextStyle(
                                color:
                                    Colors.white,
                                fontSize: 15,
                                fontWeight:
                                    FontWeight
                                        .w700,
                              ),
                            ),
                          ),

                          Icon(
                            Icons
                                .arrow_forward_rounded,
                            color: Colors
                                .white
                                .withOpacity(
                              0.75,
                            ),
                            size: 19,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // =====================================================
            // RISULTATI RICERCA
            // =====================================================

            if (_ricerca.isNotEmpty)
              Positioned(
                left: 16,
                right: 16,
                top: 0,

                child: Container(
                  constraints:
                      const BoxConstraints(
                    maxHeight: 400,
                  ),

                  decoration:
                      BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),

                    border: Border.all(
                      color:
                          const Color(
                        0xFFE8E8E8,
                      ),
                    ),
                  ),

                  child: risultati.isEmpty
                      ? const Padding(
                          padding:
                              EdgeInsets.all(
                            20,
                          ),

                          child: Text(
                            'Nessuna partita trovata.',

                            style:
                                TextStyle(
                              fontSize: 13,
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap:
                              true,

                          padding:
                              const EdgeInsets
                                  .all(
                            10,
                          ),

                          itemCount:
                              risultati.length,

                          separatorBuilder:
                              (
                            context,
                            index,
                          ) =>
                                  const SizedBox(
                            height: 5,
                          ),

                          itemBuilder:
                              (
                            context,
                            index,
                          ) {
                            final partita =
                                risultati[
                                    index];

                            final bool vinta =
                                partita.risultato
                                        .toUpperCase() ==
                                    'V';

                            return Material(
                              color:
                                  const Color(
                                0xFFF6F6F6,
                              ),

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                13,
                              ),

                              child: InkWell(
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  13,
                                ),

                                onTap:
                                    () async {
                                  await Navigator
                                      .push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (
                                        context,
                                      ) =>
                                          DettaglioPartitaScreen(
                                        partita:
                                            partita,
                                      ),
                                    ),
                                  );

                                  if (!mounted) {
                                    return;
                                  }

                                  setState(
                                    () {},
                                  );
                                },

                                child:
                                    Padding(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal:
                                        12,
                                    vertical:
                                        11,
                                  ),

                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            32,
                                        height:
                                            32,

                                        decoration:
                                            BoxDecoration(
                                          color:
                                              vinta
                                                  ? const Color(
                                                      0xFFEAF6EE,
                                                    )
                                                  : const Color(
                                                      0xFFFBECEC,
                                                    ),

                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                            10,
                                          ),
                                        ),

                                        child:
                                            Icon(
                                          vinta
                                              ? Icons
                                                  .check_rounded
                                              : Icons
                                                  .close_rounded,

                                          size: 16,

                                          color:
                                              vinta
                                                  ? const Color(
                                                      0xFF248A49,
                                                    )
                                                  : const Color(
                                                      0xFFC63D3D,
                                                    ),
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 10,
                                      ),

                                      Expanded(
                                        child:
                                            Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,

                                          children: [
                                            Text(
                                              'vs ${partita.avversario}',

                                              maxLines:
                                                  1,

                                              overflow:
                                                  TextOverflow
                                                      .ellipsis,

                                              style:
                                                  const TextStyle(
                                                fontSize:
                                                    13,
                                                fontWeight:
                                                    FontWeight
                                                        .w800,
                                              ),
                                            ),

                                            const SizedBox(
                                              height:
                                                  3,
                                            ),

                                            Text(
                                              '${partita.categoria} • ${partita.luogo}',

                                              style:
                                                  TextStyle(
                                                fontSize:
                                                    10,
                                                color:
                                                    Colors
                                                        .grey
                                                        .shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Text(
                                        vinta
                                            ? 'V'
                                            : 'P',

                                        style:
                                            TextStyle(
                                          fontSize:
                                              12,

                                          fontWeight:
                                              FontWeight
                                                  .w900,

                                          color:
                                              vinta
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
                              ),
                            );
                          },
                        ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
