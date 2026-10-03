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

  // =========================
  // CREA STAGIONE
  // =========================

  Future<void> creaNuovaStagione() async {
    final controller = TextEditingController();

    final String? nome = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Nuova stagione',
          ),

          content: TextField(
            controller: controller,
            autofocus: true,

            decoration: const InputDecoration(
              labelText: 'Nome stagione',
              hintText: 'es. 2027/28',
              border: OutlineInputBorder(),
            ),

            onSubmitted: (value) {
              Navigator.of(dialogContext).pop(
                value.trim(),
              );
            },
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'Annulla',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(
                  controller.text.trim(),
                );
              },
              child: const Text(
                'Crea',
              ),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (!mounted) {
      return;
    }

    if (nome == null || nome.isEmpty) {
      return;
    }

    try {
      await ArchivioStagioni.creaStagione(
        nome,
      );

      if (!mounted) {
        return;
      }

      // Aspettiamo che Flutter abbia terminato
      // il ciclo corrente del dialog.
      await Future<void>.delayed(
        const Duration(milliseconds: 100),
      );

      if (!mounted) {
        return;
      }

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Stagione "$nome" creata.',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      await Future<void>.delayed(
        const Duration(milliseconds: 100),
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Esiste già una stagione con questo nome.',
          ),
        ),
      );
    }
  }

  // =========================
  // ELIMINA STAGIONE
  // =========================

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
          title: const Text(
            'Eliminare la stagione?',
          ),

          content: Text(
            'Stai per eliminare "${stagione.nome}".\n\n'
            'Verranno eliminate anche tutte le partite '
            'e tutti i dati statistici di questa stagione.\n\n'
            'Questa operazione non può essere annullata.',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(
                  false,
                );
              },
              child: const Text(
                'Annulla',
              ),
            ),

            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),

              onPressed: () {
                Navigator.of(dialogContext).pop(
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

    if (!mounted || conferma != true) {
      return;
    }

    await ArchivioStagioni.eliminaStagione(
      indice,
    );

    if (!mounted) {
      return;
    }

    await Future<void>.delayed(
      const Duration(milliseconds: 100),
    );

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Stagione eliminata.',
        ),
      ),
    );
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    final stagioni =
        ArchivioStagioni.stagioni;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seleziona stagione',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: stagioni.length,

                separatorBuilder:
                    (context, index) =>
                        const SizedBox(height: 10),

                itemBuilder: (context, index) {
                  final stagione =
                      stagioni[index];

                  final bool attiva =
                      index ==
                      ArchivioStagioni
                          .indiceStagioneAttiva;

                  return Card(
                    child: ListTile(
                      onTap: () {
                        ArchivioStagioni
                            .cambiaStagione(
                          index,
                        );

                        Navigator.of(context).pop(
                          true,
                        );
                      },

                      leading: CircleAvatar(
                        child: Icon(
                          attiva
                              ? Icons.check
                              : Icons.calendar_month,
                        ),
                      ),

                      title: Text(
                        stagione.nome,
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      subtitle: Text(
                        '${stagione.partite.length} partite',
                      ),

                      trailing: Row(
                        mainAxisSize:
                            MainAxisSize.min,

                        children: [
                          if (attiva)
                            const Icon(
                              Icons.check_circle,
                            ),

                          const SizedBox(
                            width: 8,
                          ),

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
                              Icons.delete_outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed:
                    creaNuovaStagione,

                icon: const Icon(
                  Icons.add,
                ),

                label: const Text(
                  'Nuova stagione',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}