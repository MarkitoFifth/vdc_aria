import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'services/archivio_stagioni.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ArchivioStagioni.inizializza();

  runApp(const Rally());
}

class Rally extends StatelessWidget {
  const Rally({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rally',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

