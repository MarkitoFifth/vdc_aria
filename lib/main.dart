import 'package:flutter/material.dart';

import 'screens/nuova_partita_screen.dart';
import 'screens/tutte_partite_screen.dart';
import 'services/archivio_partite.dart';
import 'widgets/ultime_partite_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Volley Data Center By ARIA',

      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),

      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {
  Future<void> apriNuovaPartita() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const NuovaPartitaScreen();
        },
      ),
    );

    setState(() {});
  }

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

  @override
  Widget build(BuildContext context) {
    final ultimePartite =
        archivioPartite.reversed.take(5).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Volley Data Center By ARIA',
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            UltimePartiteWidget(
              partite: ultimePartite,
              onTap: apriTuttePartite,
            ),

            const SizedBox(height: 20),

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

