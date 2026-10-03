class DatiAttacchi {
  final int attacchiEffettuati;
  final int attacchiPunto;
  final int attacchiErrori;
  final int attacchiMurati;

  DatiAttacchi({
    required this.attacchiEffettuati,
    required this.attacchiErrori,
    required this.attacchiPunto,
    required this.attacchiMurati,
  });
}

class DatiMuro {
  final int muriEffettuati;
  final int muriPunto;
  final int muriErrori;

  DatiMuro({
    required this.muriEffettuati,
    required this.muriErrori,
    required this.muriPunto,
  });
}

class DatiBattuta {
  final int battuteEffettuate;
  final int battutePunto;
  final int battuteErrori;

  DatiBattuta({
    required this.battuteEffettuate,
    required this.battuteErrori,
    required this.battutePunto,
  });
}

class DatiRicezione {
  final int ricezioniEffettuate;
  final int ricezioniPositive;
  final int ricezioniNegative;
  final int ricezioniErrori;

  DatiRicezione({
    required this.ricezioniEffettuate,
    required this.ricezioniPositive,
    required this.ricezioniNegative,
    required this.ricezioniErrori,
  });
}

class DatiDifesa {
  final int difeseEffettuate;
  final int difesePositive;
  final int difeseNegative;
  final int difeseErrore;

  DatiDifesa({
    required this.difeseEffettuate,
    required this.difesePositive,
    required this.difeseNegative,
    required this.difeseErrore,
  });
}

class Partita {
  final String avversario;
  final String categoria;
  final String risultato;
  final String luogo;
  final DateTime data;

  final DatiAttacchi attacchi;
  final DatiMuro muro;
  final DatiBattuta battuta;
  final DatiRicezione ricezione;
  final DatiDifesa difesa;

  Partita({
    required this.avversario,
    required this.categoria,
    required this.risultato,
    required this.luogo,
    required this.data,
    required this.attacchi,
    required this.muro,
    required this.battuta,
    required this.ricezione,
    required this.difesa,
  });
}