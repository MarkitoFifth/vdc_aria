import 'package:flutter/material.dart';

import '../dati_inseribili/dati.dart';

class UltimePartiteWidget extends StatelessWidget {
  final List<Partita> partite;
  final VoidCallback onTap;

  const UltimePartiteWidget({
    super.key,
    required this.partite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [
                  const Text(
                    'Ultime partite',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                ],
              ),

              const SizedBox(height: 15),

              if (partite.isEmpty)
                const Text(
                  'Nessuna partita inserita',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

              ...partite.map(
                (partita) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 6,
                    ),

                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            partita.avversario,
                            style:
                                const TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.w500,
                            ),
                          ),
                        ),

                        Text(
                          partita.risultato == 'V'
                              ? 'VINTA'
                              : 'PERSA',

                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,

                            color:
                                partita.risultato == 'V'
                                    ? Colors.green
                                    : Colors.red,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Text(
                          partita.categoria,
                          style:
                              const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}