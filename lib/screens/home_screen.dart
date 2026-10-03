import 'package:flutter/material.dart';

import '../widgets/ultima_partita_widget.dart';
import '../widgets/ultime_partite_widget.dart';
import '../widgets/medie_statistiche_widget.dart';
import '../widgets/grafico_andamento_widget.dart';
import 'nuova_partita_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // ======================================================
      // APP BAR
      // ======================================================

      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,

        title: const Text(
          'Volley Data Center',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ======================================================
      // BODY
      // ======================================================

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [

              // ==================================================
              // ULTIMA PARTITA
              // ==================================================

              UltimaPartitaWidget(),

              const SizedBox(height: 14),

              // ==================================================
              // ULTIME PARTITE + MEDIE STAGIONALI
              // ==================================================

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Expanded(
                    flex: 45,
                    child: UltimePartiteWidget(),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    flex: 55,
                    child: MedieStatisticheWidget(),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ==================================================
              // GRAFICO PRINCIPALE
              // ==================================================

              GraficoAndamentoWidget(),

              const SizedBox(height: 20),

              // ==================================================
              // AGGIUNGI NUOVA PARTITA
              // ==================================================

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

                    // Quando torniamo dalla schermata
                    // di inserimento partita, aggiorniamo
                    // tutta la Home.
                    setState(() {});
                  },

                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 4,
                    ),

                    child: Text(
                      'Aggiungi una nuova partita',
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}