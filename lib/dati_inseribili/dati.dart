class DatiAttacchi {
  final int attacchiEffettuati;
  final int attacchiPunto;
  final int attacchiErrori;

  DatiAttacchi({
    required this.attacchiEffettuati,
    required this.attacchiErrori,
    required this.attacchiPunto,
  });
}

class DatiMuro {
  final int muriPunto;
  final int muriErrori;

  DatiMuro({
    required this.muriPunto,
    required this.muriErrori,
  });
}

class DatiBattuta {
  final int battuteEffettuate;
  final int battutePunto;
  final int battuteErrori;

  DatiBattuta({
    required this.battuteEffettuate,
    required this.battutePunto,
    required this.battuteErrori,
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

  Partita({
    required this.avversario,
    required this.categoria,
    required this.risultato,
    required this.luogo,
    required this.data,
  });
}