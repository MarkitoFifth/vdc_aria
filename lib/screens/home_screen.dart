import 'package:flutter/material.dart';

import '../services/archivio_stagioni.dart';

import '../widgets/ultima_partita_widget.dart';
import '../widgets/ultime_partite_widget.dart';
import '../widgets/medie_statistiche_widget.dart';
import '../widgets/grafico_andamento_widget.dart';

import 'nuova_partita_screen.dart';
import 'selezione_stagione_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFF5F5F5),
        elevation: 0,

        title: const Text(
          'Volley Data Center',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          Padding(
            padding:
                const EdgeInsets.only(
              right: 12,
            ),
            child: TextButton.icon(
              onPressed:
                  apriSelezioneStagione,
              icon: const Icon(
                Icons.keyboard_arrow_down,
              ),
              label: Text(
                ArchivioStagioni
                    .stagioneAttiva
                    .nome,
              ),
              style: TextButton.styleFrom(
                foregroundColor:
                    Colors.black,
                backgroundColor:
                    Colors.white,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(16),
          child: Column(
            children: [
              UltimaPartitaWidget(),

              const SizedBox(height: 14),

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
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

              const SizedBox(height: 14),

              GraficoAndamentoWidget(),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const NuovaPartitaScreen(),
                      ),
                    );

                    setState(() {});
                  },
                  child: const Text(
                    'Aggiungi una nuova partita',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}