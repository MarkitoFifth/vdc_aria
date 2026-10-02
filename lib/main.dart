import 'package:flutter/material.dart';

import 'screens/nuova_partita_screen.dart';
import 'screens/tutte_partite_screen.dart';

import 'services/archivio_partite.dart';

import 'widgets/ultime_partite_widget.dart';

void main() {
  runApp(const MainApp());
}


// ============================================
// APP PRINCIPALE
// ============================================

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Volley Data Center By ARIA',

      home: const HomeScreen(),
    );
  }
}


// ============================================
// HOME
// ============================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


// ============================================
// STATO DELLA HOME
// ============================================

class _HomeScreenState extends State<HomeScreen> {

  // ==========================================
  // NUOVA PARTITA
  // ==========================================

  Future<void> apriNuovaPartita() async {
    await Navigator.push(
      context,

      MaterialPageRoute(
        builder: (context) {
          return const NuovaPartitaScreen();
        },
      ),
    );

    // Quando torniamo indietro,
    // aggiorniamo la Home
    setState(() {});
  }


  // ==========================================
  // TUTTE LE PARTITE
  // ==========================================

  void apriTuttePartite() {
    Navigator.push(
      context,

      MaterialPageRoute(
        builder: (context) {
          return const TuttePartiteScreen();
        },
      ),
    );
  }


  // ==========================================
  // BUILD
  // ==========================================

  @override
  Widget build(BuildContext context) {

    // Prendiamo le ultime 5 partite.
    //
    // reversed significa che la più recente
    // viene mostrata per prima.

    final ultimePartite =
        archivioPartite.reversed.take(5).toList();


    return Scaffold(

      // ========================================
      // APP BAR
      // ========================================

      appBar: AppBar(
        title: const Text(
          'Volley Data Center By ARIA',
        ),
      ),


      // ========================================
      // CORPO
      // ========================================

      body: SingleChildScrollView(

        child: Column(
          children: [

            // ==================================
            // WIDGET ULTIME PARTITE
            // ==================================

            UltimePartiteWidget(
              partite: ultimePartite,

              onTap: apriTuttePartite,
            ),


            const SizedBox(height: 20),


            // ==================================
            // BOTTONE NUOVA PARTITA
            // ==================================

            ElevatedButton.icon(

              onPressed: apriNuovaPartita,

              icon: const Icon(
                Icons.add,
              ),

              label: const Text(
                'Aggiungi una nuova partita',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

