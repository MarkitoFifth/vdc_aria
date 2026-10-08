import 'package:flutter/material.dart';

import '../screens/scout_partita_screen.dart';

class NuovaPartitaScreen extends StatefulWidget {
  const NuovaPartitaScreen({super.key});

  @override
  State<NuovaPartitaScreen> createState() =>
      _NuovaPartitaScreenState();
}

class _NuovaPartitaScreenState
    extends State<NuovaPartitaScreen> {
  final TextEditingController avversarioController =
      TextEditingController();

  String categoriaSelezionata = 'Serie C';
  String risultatoSelezionato = 'V';
  String luogoSelezionato = 'C';

  DateTime? dataSelezionata;

  // =========================================================
  // SELEZIONE DATA
  // =========================================================

  Future<void> selezionaData() async {
    final oggi = DateTime.now();

    DateTime meseVisualizzato = DateTime(
      dataSelezionata?.year ?? oggi.year,
      dataSelezionata?.month ?? oggi.month,
    );

    DateTime? dataTemporanea = dataSelezionata;

    final DateTime? risultato =
        await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final giorniNelMese = DateUtils.getDaysInMonth(
              meseVisualizzato.year,
              meseVisualizzato.month,
            );

            final primoGiorno = DateTime(
              meseVisualizzato.year,
              meseVisualizzato.month,
              1,
            );

            // Lunedì = 0 ... Domenica = 6
            final offset =
                (primoGiorno.weekday - 1) % 7;

            return SafeArea(
              child: Container(
                margin: const EdgeInsets.only(top: 70),
                padding: const EdgeInsets.fromLTRB(
                  20,
                  12,
                  20,
                  24,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F6F8),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    // =================================================
                    // INDICATORE
                    // =================================================

                    Container(
                      width: 42,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // =================================================
                    // HEADER
                    // =================================================

                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Seleziona la data',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 20,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        dataTemporanea == null
                            ? 'Scegli quando si è giocata la partita'
                            : _dataCompleta(
                                dataTemporanea!,
                              ),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // =================================================
                    // MESE
                    // =================================================

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [

                          GestureDetector(
                            onTap: () {
                              setModalState(() {
                                meseVisualizzato = DateTime(
                                  meseVisualizzato.year,
                                  meseVisualizzato.month - 1,
                                );
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFF5F6F8),
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.chevron_left,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    _nomeMese(
                                      meseVisualizzato.month,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight:
                                          FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${meseVisualizzato.year}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color:
                                          Colors.grey.shade500,
                                      fontWeight:
                                          FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setModalState(() {
                                meseVisualizzato = DateTime(
                                  meseVisualizzato.year,
                                  meseVisualizzato.month + 1,
                                );
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFF5F6F8),
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.chevron_right,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // =================================================
                    // CALENDARIO
                    // =================================================

                    Container(
                      padding: const EdgeInsets.fromLTRB(
                        14,
                        16,
                        14,
                        14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [

                          // Giorni settimana
                          Row(
                            children: const [
                              _GiornoSettimana('L'),
                              _GiornoSettimana('M'),
                              _GiornoSettimana('M'),
                              _GiornoSettimana('G'),
                              _GiornoSettimana('V'),
                              _GiornoSettimana('S'),
                              _GiornoSettimana('D'),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // Giorni
                          ...List.generate(
                            ((offset + giorniNelMese) / 7)
                                .ceil(),
                            (settimana) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(
                                  bottom: 4,
                                ),
                                child: Row(
                                  children:
                                      List.generate(
                                    7,
                                    (giornoSettimana) {
                                      final indice =
                                          settimana * 7 +
                                              giornoSettimana;

                                      final giorno =
                                          indice - offset + 1;

                                      if (giorno < 1 ||
                                          giorno >
                                              giorniNelMese) {
                                        return const Expanded(
                                          child: SizedBox(
                                            height: 44,
                                          ),
                                        );
                                      }

                                      final data = DateTime(
                                        meseVisualizzato.year,
                                        meseVisualizzato.month,
                                        giorno,
                                      );

                                      final selezionato =
                                          dataTemporanea !=
                                                  null &&
                                              _stessaData(
                                                dataTemporanea!,
                                                data,
                                              );

                                      final oggiSelezionato =
                                          _stessaData(
                                        oggi,
                                        data,
                                      );

                                      return Expanded(
                                        child:
                                            GestureDetector(
                                          onTap: () {
                                            setModalState(() {
                                              dataTemporanea =
                                                  data;
                                            });
                                          },
                                          child: Container(
                                            height: 44,
                                            margin:
                                                const EdgeInsets
                                                    .all(2),
                                            decoration:
                                                BoxDecoration(
                                              color: selezionato
                                                  ? Colors.black
                                                  : Colors
                                                      .transparent,
                                              borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                13,
                                              ),
                                              border:
                                                  oggiSelezionato &&
                                                          !selezionato
                                                      ? Border.all(
                                                          color:
                                                              Colors.black26,
                                                          width:
                                                              1.2,
                                                        )
                                                      : null,
                                            ),
                                            child: Center(
                                              child: Text(
                                                '$giorno',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      selezionato
                                                          ? FontWeight
                                                              .w800
                                                          : FontWeight
                                                              .w600,
                                                  color:
                                                      selezionato
                                                          ? Colors.white
                                                          : Colors
                                                              .black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // =================================================
                    // CONFERMA
                    // =================================================

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed:
                            dataTemporanea == null
                                ? null
                                : () {
                                    Navigator.pop(
                                      context,
                                      dataTemporanea,
                                    );
                                  },
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor:
                              Colors.grey.shade300,
                          disabledForegroundColor:
                              Colors.grey.shade500,
                          elevation: 0,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(17),
                          ),
                        ),
                        child: const Text(
                          'CONFERMA DATA',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.4,
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
      },
    );

    if (risultato != null && mounted) {
      setState(() {
        dataSelezionata = risultato;
      });
    }
  }

  // =========================================================
  // CONTINUA SCOUTING
  // =========================================================

  void continuaScouting() {
    if (avversarioController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Inserisci la squadra avversaria',
          ),
        ),
      );

      return;
    }

    if (dataSelezionata == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Seleziona la data della partita',
          ),
        ),
      );

      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ScoutPartitaScreen(
            avversario:
                avversarioController.text.trim(),
            categoria: categoriaSelezionata,
            risultato: risultatoSelezionato,
            luogo: luogoSelezionato,
            data: dataSelezionata!,
          );
        },
      ),
    );
  }

  // =========================================================
  // DATA FORMATTATA
  // =========================================================

  String dataFormattata() {
    if (dataSelezionata == null) {
      return 'Seleziona la data';
    }

    return '${dataSelezionata!.day.toString().padLeft(2, '0')}/'
        '${dataSelezionata!.month.toString().padLeft(2, '0')}/'
        '${dataSelezionata!.year}';
  }

  String _dataCompleta(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')} '
        '${_nomeMese(data.month)} '
        '${data.year}';
  }

  String _nomeMese(int mese) {
    const mesi = [
      'Gennaio',
      'Febbraio',
      'Marzo',
      'Aprile',
      'Maggio',
      'Giugno',
      'Luglio',
      'Agosto',
      'Settembre',
      'Ottobre',
      'Novembre',
      'Dicembre',
    ];

    return mesi[mese - 1];
  }

  bool _stessaData(
    DateTime a,
    DateTime b,
  ) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  @override
  void dispose() {
    avversarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Nuova partita',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            10,
            20,
            30,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              // =========================================================
              // HEADER
              // =========================================================

              const Text(
                'Prepariamo la partita',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.7,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Inserisci le informazioni della gara '
                'prima di iniziare lo scouting.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 25),

              // =========================================================
              // AVVERSARIO
              // =========================================================

              _sezioneTitolo(
                icon: Icons.sports_volleyball,
                titolo: 'Avversario',
              ),

              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: avversarioController,
                  textCapitalization:
                      TextCapitalization.words,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    hintText:
                        'Nome della squadra',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Container(
                      margin:
                          const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue
                            .withOpacity(0.10),
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.shield_outlined,
                        color: Colors.blue,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // =========================================================
              // CATEGORIA + DATA
              // =========================================================

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        _sezioneTitolo(
                          icon:
                              Icons.emoji_events_outlined,
                          titolo: 'Categoria',
                        ),

                        const SizedBox(height: 10),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          child:
                              DropdownButtonFormField<String>(
                            initialValue:
                                categoriaSelezionata,
                            decoration:
                                const InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 5,
                              ),
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'Serie C',
                                child: Text('Serie C'),
                              ),
                              DropdownMenuItem(
                                value: 'Under 19',
                                child: Text('Under 19'),
                              ),
                            ],
                            onChanged: (valore) {
                              if (valore == null) return;

                              setState(() {
                                categoriaSelezionata =
                                    valore;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        _sezioneTitolo(
                          icon:
                              Icons.calendar_today_outlined,
                          titolo: 'Data',
                        ),

                        const SizedBox(height: 10),

                        GestureDetector(
                          onTap: selezionaData,
                          child: Container(
                            height: 58,
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 14,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: 21,
                                  color:
                                      dataSelezionata ==
                                              null
                                          ? Colors.grey
                                          : Colors.black,
                                ),

                                const SizedBox(width: 8),

                                Expanded(
                                  child: Text(
                                    dataFormattata(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight:
                                          FontWeight.w600,
                                      color:
                                          dataSelezionata ==
                                                  null
                                              ? Colors
                                                  .grey
                                                  .shade500
                                              : Colors
                                                  .black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // =========================================================
              // CASA / FUORI
              // =========================================================

              _sezioneTitolo(
                icon: Icons.location_on_outlined,
                titolo: 'Dove si gioca?',
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _opzioneCard(
                      titolo: 'Casa',
                      sottotitolo: 'In casa',
                      icona: Icons.home_outlined,
                      selezionata:
                          luogoSelezionato == 'C',
                      onTap: () {
                        setState(() {
                          luogoSelezionato = 'C';
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _opzioneCard(
                      titolo: 'Fuori casa',
                      sottotitolo: 'Trasferta',
                      icona:
                          Icons.directions_bus_outlined,
                      selezionata:
                          luogoSelezionato == 'F',
                      onTap: () {
                        setState(() {
                          luogoSelezionato = 'F';
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // =========================================================
              // RISULTATO
              // =========================================================

              _sezioneTitolo(
                icon: Icons.flag_outlined,
                titolo: 'Risultato',
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _risultatoCard(
                      titolo: 'Vinta',
                      icona:
                          Icons.check_circle_outline,
                      selezionata:
                          risultatoSelezionato == 'V',
                      colore: Colors.green,
                      onTap: () {
                        setState(() {
                          risultatoSelezionato = 'V';
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _risultatoCard(
                      titolo: 'Persa',
                      icona: Icons.cancel_outlined,
                      selezionata:
                          risultatoSelezionato == 'S',
                      colore: Colors.red,
                      onTap: () {
                        setState(() {
                          risultatoSelezionato = 'S';
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // =========================================================
              // RIEPILOGO
              // =========================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withOpacity(0.12),
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.sports_volleyball,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            avversarioController.text
                                    .trim()
                                    .isEmpty
                                ? 'La tua partita'
                                : avversarioController
                                    .text
                                    .trim(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            '$categoriaSelezionata  •  '
                            '${luogoSelezionato == 'C' ? 'Casa' : 'Trasferta'}',
                            style: TextStyle(
                              color: Colors.white
                                  .withOpacity(0.65),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // =========================================================
              // PULSANTE
              // =========================================================

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: continuaScouting,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_arrow_rounded,
                        size: 27,
                      ),

                      SizedBox(width: 8),

                      Text(
                        'INIZIA SCOUT',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // TITOLO SEZIONE
  // =========================================================

  Widget _sezioneTitolo({
    required IconData icon,
    required String titolo,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 19,
          color: Colors.black87,
        ),

        const SizedBox(width: 8),

        Text(
          titolo,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  // =========================================================
  // CARD CASA / FUORI
  // =========================================================

  Widget _opzioneCard({
    required String titolo,
    required String sottotitolo,
    required IconData icona,
    required bool selezionata,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: selezionata
              ? Colors.blue.withOpacity(0.08)
              : Colors.white,
          borderRadius:
              BorderRadius.circular(18),
          border: Border.all(
            color: selezionata
                ? Colors.blue
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icona,
              color: selezionata
                  ? Colors.blue
                  : Colors.grey.shade600,
              size: 27,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    titolo,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    sottotitolo,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            if (selezionata)
              const Icon(
                Icons.check_circle,
                color: Colors.blue,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // CARD RISULTATO
  // =========================================================

  Widget _risultatoCard({
    required String titolo,
    required IconData icona,
    required bool selezionata,
    required Color colore,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 180),
        height: 62,
        decoration: BoxDecoration(
          color: selezionata
              ? colore.withOpacity(0.09)
              : Colors.white,
          borderRadius:
              BorderRadius.circular(18),
          border: Border.all(
            color: selezionata
                ? colore
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icona,
              color: selezionata
                  ? colore
                  : Colors.grey.shade500,
            ),

            const SizedBox(width: 8),

            Text(
              titolo,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: selezionata
                    ? colore
                    : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================
// GIORNO DELLA SETTIMANA
// =============================================================

class _GiornoSettimana extends StatelessWidget {
  final String giorno;

  const _GiornoSettimana(this.giorno);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          giorno,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
}