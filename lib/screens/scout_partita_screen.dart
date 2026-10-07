import 'package:flutter/material.dart';

import '../dati_inseribili/dati.dart';
import '../services/archivio_stagioni.dart';

class ScoutPartitaScreen extends StatefulWidget {
  final String avversario;
  final String categoria;
  final String risultato;
  final String luogo;
  final DateTime data;

  const ScoutPartitaScreen({
    super.key,
    required this.avversario,
    required this.categoria,
    required this.risultato,
    required this.luogo,
    required this.data,
  });

  @override
  State<ScoutPartitaScreen> createState() =>
      _ScoutPartitaScreenState();
}

class _ScoutPartitaScreenState
    extends State<ScoutPartitaScreen> {
  // =========================
  // ATTACCO
  // =========================

  final TextEditingController attacchiEffettuati =
      TextEditingController();

  final TextEditingController attacchiPunto =
      TextEditingController();

  final TextEditingController attacchiErrori =
      TextEditingController();

  final TextEditingController attacchiMurati =
      TextEditingController();

  // =========================
  // BATTUTA
  // =========================

  final TextEditingController battuteEffettuate =
      TextEditingController();

  final TextEditingController battutePunto =
      TextEditingController();

  final TextEditingController battuteErrori =
      TextEditingController();

  // =========================
  // RICEZIONE
  // =========================

  final TextEditingController ricezioniEffettuate =
      TextEditingController();

  final TextEditingController ricezioniPositive =
      TextEditingController();

  final TextEditingController ricezioniNegative =
      TextEditingController();

  final TextEditingController ricezioniErrori =
      TextEditingController();

  // =========================
  // MURO
  // =========================

  final TextEditingController muriEffettuati =
      TextEditingController();

  final TextEditingController muriPunto =
      TextEditingController();

  final TextEditingController muriErrori =
      TextEditingController();

  // =========================
  // DIFESA
  // =========================

  final TextEditingController difeseEffettuate =
      TextEditingController();

  final TextEditingController difesePositive =
      TextEditingController();

  final TextEditingController difeseNegative =
      TextEditingController();

  final TextEditingController difeseErrori =
      TextEditingController();

  // =========================
  // CONVERSIONE VALORI
  // =========================

  int valore(
    TextEditingController controller,
  ) {
    return int.tryParse(
          controller.text.trim(),
        ) ??
        0;
  }

  // =========================
  // SALVATAGGIO PARTITA
  // =========================

  Future<void> salvaPartita() async {
    final Partita nuovaPartita = Partita(
      avversario: widget.avversario,
      categoria: widget.categoria,
      risultato: widget.risultato,
      luogo: widget.luogo,
      data: widget.data,

      attacchi: DatiAttacchi(
        attacchiEffettuati:
            valore(attacchiEffettuati),
        attacchiPunto:
            valore(attacchiPunto),
        attacchiErrori:
            valore(attacchiErrori),
        attacchiMurati:
            valore(attacchiMurati),
      ),

      battuta: DatiBattuta(
        battuteEffettuate:
            valore(battuteEffettuate),
        battutePunto:
            valore(battutePunto),
        battuteErrori:
            valore(battuteErrori),
      ),

      ricezione: DatiRicezione(
        ricezioniEffettuate:
            valore(ricezioniEffettuate),
        ricezioniPositive:
            valore(ricezioniPositive),
        ricezioniNegative:
            valore(ricezioniNegative),
        ricezioniErrori:
            valore(ricezioniErrori),
      ),

      muro: DatiMuro(
        muriEffettuati:
            valore(muriEffettuati),
        muriPunto:
            valore(muriPunto),
        muriErrori:
            valore(muriErrori),
      ),

      difesa: DatiDifesa(
        difeseEffettuate:
            valore(difeseEffettuate),
        difesePositive:
            valore(difesePositive),
        difeseNegative:
            valore(difeseNegative),
        difeseErrore:
            valore(difeseErrori),
      ),
    );

    try {
      await ArchivioStagioni.aggiungiPartita(
        nuovaPartita,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Partita salvata!',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Errore durante il salvataggio.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // =========================
  // CAMPO NUMERICO
  // =========================

  Widget campoNumerico({
    required String titolo,
    required TextEditingController controller,
    required IconData icona,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE7E7E7),
        ),
      ),
      child: TextField(
        controller: controller,

        keyboardType:
            const TextInputType.numberWithOptions(
          decimal: false,
          signed: false,
        ),

        textAlign: TextAlign.center,

        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),

        decoration: InputDecoration(
          labelText: titolo,

          floatingLabelBehavior:
              FloatingLabelBehavior.always,

          labelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),

          prefixIcon: Icon(
            icona,
            size: 19,
            color: Colors.black45,
          ),

          hintText: '0',

          hintStyle: const TextStyle(
            color: Colors.black26,
            fontWeight: FontWeight.w700,
          ),

          border: InputBorder.none,

          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  // =========================
  // CARD SEZIONE
  // =========================

  Widget sezioneStatistiche({
    required String titolo,
    required String descrizione,
    required IconData icona,
    required List<Widget> campi,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 14,
      ),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,

                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius:
                      BorderRadius.circular(13),
                ),

                child: Icon(
                  icona,
                  color: Colors.black87,
                  size: 21,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      titolo,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      descrizione,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.65,
            children: campi,
          ),
        ],
      ),
    );
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    final bool partitaVinta =
        widget.risultato == 'V';

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFF5F5F5),
        elevation: 0,

        title: const Text(
          'Scout partita',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 21,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16,
            4,
            16,
            30,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // =========================
              // HEADER PARTITA
              // =========================

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      BorderRadius.circular(22),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,

                          decoration: BoxDecoration(
                            color: Colors.white
                                .withOpacity(0.12),
                            borderRadius:
                                BorderRadius.circular(
                              13,
                            ),
                          ),

                          child: const Icon(
                            Icons
                                .sports_volleyball_rounded,
                            color: Colors.white,
                          ),
                        ),

                        const Spacer(),

                        Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 11,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: partitaVinta
                                ? Colors.green
                                    .withOpacity(
                                    0.18,
                                  )
                                : Colors.red
                                    .withOpacity(
                                    0.18,
                                  ),
                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),
                          ),

                          child: Text(
                            partitaVinta
                                ? 'VINTA'
                                : 'PERSA',

                            style: TextStyle(
                              color: partitaVinta
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                              fontSize: 11,
                              fontWeight:
                                  FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Text(
                      'VS',
                      style: TextStyle(
                        color: Colors.white
                            .withOpacity(0.45),
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      widget.avversario,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,

                      children: [
                        _infoPill(
                          Icons
                              .emoji_events_outlined,
                          widget.categoria,
                        ),

                        _infoPill(
                          widget.luogo == 'C'
                              ? Icons.home_outlined
                              : Icons
                                  .flight_takeoff_outlined,
                          widget.luogo == 'C'
                              ? 'Casa'
                              : 'Fuori',
                        ),

                        _infoPill(
                          Icons
                              .calendar_today_outlined,
                          '${widget.data.day.toString().padLeft(2, '0')}/'
                          '${widget.data.month.toString().padLeft(2, '0')}/'
                          '${widget.data.year}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // =========================
              // INFO
              // =========================

              Row(
                children: [
                  const Icon(
                    Icons
                        .edit_note_rounded,
                    size: 21,
                    color: Colors.black54,
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    'Inserisci i dati dello scout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              const Padding(
                padding: EdgeInsets.only(
                  left: 29,
                ),
                child: Text(
                  'Compila i valori rilevati durante la partita.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // =========================
              // ATTACCO
              // =========================

              sezioneStatistiche(
                titolo: 'Attacco',
                descrizione:
                    'Azioni offensive',
                icona: Icons
                    .arrow_upward_rounded,

                campi: [
                  campoNumerico(
                    titolo: 'Effettuati',
                    controller:
                        attacchiEffettuati,
                    icona: Icons
                        .sports_volleyball,
                  ),

                  campoNumerico(
                    titolo: 'Punto',
                    controller:
                        attacchiPunto,
                    icona: Icons
                        .check_circle_outline,
                  ),

                  campoNumerico(
                    titolo: 'Errori',
                    controller:
                        attacchiErrori,
                    icona: Icons
                        .close_rounded,
                  ),

                  campoNumerico(
                    titolo: 'Murati',
                    controller:
                        attacchiMurati,
                    icona: Icons
                        .block_rounded,
                  ),
                ],
              ),

              // =========================
              // BATTUTA
              // =========================

              sezioneStatistiche(
                titolo: 'Battuta',
                descrizione:
                    'Servizio e punti diretti',
                icona: Icons
                    .sports_volleyball_outlined,

                campi: [
                  campoNumerico(
                    titolo: 'Effettuate',
                    controller:
                        battuteEffettuate,
                    icona: Icons
                        .repeat_rounded,
                  ),

                  campoNumerico(
                    titolo: 'Ace / Punto',
                    controller:
                        battutePunto,
                    icona: Icons
                        .bolt_rounded,
                  ),

                  campoNumerico(
                    titolo: 'Errori',
                    controller:
                        battuteErrori,
                    icona: Icons
                        .close_rounded,
                  ),
                ],
              ),

              // =========================
              // RICEZIONE
              // =========================

              sezioneStatistiche(
                titolo: 'Ricezione',
                descrizione:
                    'Qualità della ricezione',
                icona: Icons
                    .pan_tool_outlined,

                campi: [
                  campoNumerico(
                    titolo: 'Effettuate',
                    controller:
                        ricezioniEffettuate,
                    icona: Icons
                        .input_rounded,
                  ),

                  campoNumerico(
                    titolo: 'Positive',
                    controller:
                        ricezioniPositive,
                    icona: Icons
                        .thumb_up_alt_outlined,
                  ),

                  campoNumerico(
                    titolo: 'Negative',
                    controller:
                        ricezioniNegative,
                    icona: Icons
                        .remove_circle_outline,
                  ),

                  campoNumerico(
                    titolo: 'Errori',
                    controller:
                        ricezioniErrori,
                    icona: Icons
                        .close_rounded,
                  ),
                ],
              ),

              // =========================
              // MURO
              // =========================

              sezioneStatistiche(
                titolo: 'Muro',
                descrizione:
                    'Blocchi a rete',
                icona: Icons
                    .vertical_align_bottom_rounded,

                campi: [
                  campoNumerico(
                    titolo: 'Effettuati',
                    controller:
                        muriEffettuati,
                    icona: Icons
                        .height_rounded,
                  ),

                  campoNumerico(
                    titolo: 'Punto',
                    controller:
                        muriPunto,
                    icona: Icons
                        .check_circle_outline,
                  ),

                  campoNumerico(
                    titolo: 'Errori',
                    controller:
                        muriErrori,
                    icona: Icons
                        .close_rounded,
                  ),
                ],
              ),

              // =========================
              // DIFESA
              // =========================

              sezioneStatistiche(
                titolo: 'Difesa',
                descrizione:
                    'Azioni difensive',
                icona: Icons
                    .shield_outlined,

                campi: [
                  campoNumerico(
                    titolo: 'Effettuate',
                    controller:
                        difeseEffettuate,
                    icona: Icons
                        .sports_volleyball,
                  ),

                  campoNumerico(
                    titolo: 'Positive',
                    controller:
                        difesePositive,
                    icona: Icons
                        .thumb_up_alt_outlined,
                  ),

                  campoNumerico(
                    titolo: 'Negative',
                    controller:
                        difeseNegative,
                    icona: Icons
                        .remove_circle_outline,
                  ),

                  campoNumerico(
                    titolo: 'Errori',
                    controller:
                        difeseErrori,
                    icona: Icons
                        .close_rounded,
                  ),
                ],
              ),

              // =========================
              // SALVA
              // =========================

              const SizedBox(height: 4),

              SizedBox(
                width: double.infinity,
                height: 56,

                child: FilledButton.icon(
                  onPressed: salvaPartita,

                  icon: const Icon(
                    Icons.check_rounded,
                  ),

                  label: const Text(
                    'SALVA PARTITA',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),

                  style:
                      FilledButton.styleFrom(
                    backgroundColor:
                        Colors.black,
                    foregroundColor:
                        Colors.white,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // INFO PILL
  // =========================

  Widget _infoPill(
    IconData icona,
    String testo,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),

      decoration: BoxDecoration(
        color: Colors.white
            .withOpacity(0.10),
        borderRadius:
            BorderRadius.circular(20),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          Icon(
            icona,
            size: 14,
            color: Colors.white70,
          ),

          const SizedBox(width: 5),

          Text(
            testo,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // DISPOSE
  // =========================

  @override
  void dispose() {
    attacchiEffettuati.dispose();
    attacchiPunto.dispose();
    attacchiErrori.dispose();
    attacchiMurati.dispose();

    battuteEffettuate.dispose();
    battutePunto.dispose();
    battuteErrori.dispose();

    ricezioniEffettuate.dispose();
    ricezioniPositive.dispose();
    ricezioniNegative.dispose();
    ricezioniErrori.dispose();

    muriEffettuati.dispose();
    muriPunto.dispose();
    muriErrori.dispose();

    difeseEffettuate.dispose();
    difesePositive.dispose();
    difeseNegative.dispose();
    difeseErrori.dispose();

    super.dispose();
  }
}