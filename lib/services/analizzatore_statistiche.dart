import '../dati_inseribili/dati.dart';

class AnalizzatoreStatistiche {
  // ============================================================
  // ATTACCO
  // ============================================================

  static double calcolaKillPercentuale(DatiAttacchi dati) {
    if (dati.attacchiEffettuati == 0) return 0;

    return (dati.attacchiPunto / dati.attacchiEffettuati) * 100;
  }

  static double calcolaEfficienzaAttacco(DatiAttacchi dati) {
    if (dati.attacchiEffettuati == 0) return 0;

    return ((dati.attacchiPunto -
                dati.attacchiErrori -
                dati.attacchiMurati) /
            dati.attacchiEffettuati) *
        100;
  }

  static double calcolaErroreAttacco(DatiAttacchi dati) {
    if (dati.attacchiEffettuati == 0) return 0;

    return (dati.attacchiErrori / dati.attacchiEffettuati) * 100;
  }

  static double calcolaMuratoAttacco(DatiAttacchi dati) {
    if (dati.attacchiEffettuati == 0) return 0;

    return (dati.attacchiMurati / dati.attacchiEffettuati) * 100;
  }

  // ============================================================
  // BATTUTA
  // ============================================================

  static double calcolaAcePercentuale(DatiBattuta dati) {
    if (dati.battuteEffettuate == 0) return 0;

    return (dati.battutePunto / dati.battuteEffettuate) * 100;
  }

  static double calcolaErroreBattuta(DatiBattuta dati) {
    if (dati.battuteEffettuate == 0) return 0;

    return (dati.battuteErrori / dati.battuteEffettuate) * 100;
  }

  static double calcolaEfficienzaBattuta(DatiBattuta dati) {
    if (dati.battuteEffettuate == 0) return 0;

    return ((dati.battutePunto - dati.battuteErrori) /
            dati.battuteEffettuate) *
        100;
  }

  // ============================================================
  // RICEZIONE
  // ============================================================

  static double calcolaPositivitaRicezione(DatiRicezione dati) {
    if (dati.ricezioniEffettuate == 0) return 0;

    return (dati.ricezioniPositive / dati.ricezioniEffettuate) * 100;
  }

  static double calcolaErroreRicezione(DatiRicezione dati) {
    if (dati.ricezioniEffettuate == 0) return 0;

    return (dati.ricezioniErrori / dati.ricezioniEffettuate) * 100;
  }

  static double calcolaEfficienzaRicezione(DatiRicezione dati) {
    if (dati.ricezioniEffettuate == 0) return 0;

    return ((dati.ricezioniPositive - dati.ricezioniNegative) /
            dati.ricezioniEffettuate) *
        100;
  }

  // ============================================================
  // DIFESA
  // ============================================================

  static double calcolaPositivitaDifesa(DatiDifesa dati) {
    if (dati.difeseEffettuate == 0) return 0;

    return (dati.difesePositive / dati.difeseEffettuate) * 100;
  }

  static double calcolaErroreDifesa(DatiDifesa dati) {
    if (dati.difeseEffettuate == 0) return 0;

    return (dati.difeseErrore / dati.difeseEffettuate) * 100;
  }

  static double calcolaEfficienzaDifesa(DatiDifesa dati) {
    if (dati.difeseEffettuate == 0) return 0;

    return ((dati.difesePositive - dati.difeseNegative) /
            dati.difeseEffettuate) *
        100;
  }

  // ============================================================
  // MURO
  // ============================================================

  static double calcolaBlockPercentuale(DatiMuro dati) {
    if (dati.muriEffettuati == 0) return 0;

    return (dati.muriPunto / dati.muriEffettuati) * 100;
  }

  static double calcolaErroreMuro(DatiMuro dati) {
    if (dati.muriEffettuati == 0) return 0;

    return (dati.muriErrori / dati.muriEffettuati) * 100;
  }

  static double calcolaEfficienzaMuro(DatiMuro dati) {
    if (dati.muriEffettuati == 0) return 0;

    return ((dati.muriPunto - dati.muriErrori) /
            dati.muriEffettuati) *
        100;
  }

  // ============================================================
  // PUNTI TOTALI
  // ============================================================

  static int calcolaPuntiTotali(Partita partita) {
    return partita.attacchi.attacchiPunto +
        partita.battuta.battutePunto +
        partita.muro.muriPunto;
  }

  // ============================================================
  // ERRORI TOTALI
  // ============================================================

  static int calcolaErroriTotali(Partita partita) {
    return partita.attacchi.attacchiErrori +
        partita.battuta.battuteErrori +
        partita.muro.muriErrori +
        partita.ricezione.ricezioniErrori +
        partita.difesa.difeseErrore;
  }

  // ============================================================
  // MEDIE / STATISTICHE COMPLESSIVE
  // ============================================================

  static double mediaKillPercentuale(List<Partita> partite) {
    int punti = 0;
    int tentativi = 0;

    for (final partita in partite) {
      punti += partita.attacchi.attacchiPunto;
      tentativi += partita.attacchi.attacchiEffettuati;
    }

    if (tentativi == 0) return 0;

    return (punti / tentativi) * 100;
  }

  static double mediaEfficienzaAttacco(List<Partita> partite) {
    int punti = 0;
    int errori = 0;
    int murati = 0;
    int tentativi = 0;

    for (final partita in partite) {
      punti += partita.attacchi.attacchiPunto;
      errori += partita.attacchi.attacchiErrori;
      murati += partita.attacchi.attacchiMurati;
      tentativi += partita.attacchi.attacchiEffettuati;
    }

    if (tentativi == 0) return 0;

    return ((punti - errori - murati) / tentativi) * 100;
  }

  static double mediaAcePercentuale(List<Partita> partite) {
    int ace = 0;
    int battute = 0;

    for (final partita in partite) {
      ace += partita.battuta.battutePunto;
      battute += partita.battuta.battuteEffettuate;
    }

    if (battute == 0) return 0;

    return (ace / battute) * 100;
  }

  static double mediaEfficienzaBattuta(List<Partita> partite) {
    int ace = 0;
    int errori = 0;
    int battute = 0;

    for (final partita in partite) {
      ace += partita.battuta.battutePunto;
      errori += partita.battuta.battuteErrori;
      battute += partita.battuta.battuteEffettuate;
    }

    if (battute == 0) return 0;

    return ((ace - errori) / battute) * 100;
  }

  static double mediaPositivitaRicezione(List<Partita> partite) {
    int positive = 0;
    int ricezioni = 0;

    for (final partita in partite) {
      positive += partita.ricezione.ricezioniPositive;
      ricezioni += partita.ricezione.ricezioniEffettuate;
    }

    if (ricezioni == 0) return 0;

    return (positive / ricezioni) * 100;
  }

  static double mediaEfficienzaRicezione(List<Partita> partite) {
    int positive = 0;
    int negative = 0;
    int ricezioni = 0;

    for (final partita in partite) {
      positive += partita.ricezione.ricezioniPositive;
      negative += partita.ricezione.ricezioniNegative;
      ricezioni += partita.ricezione.ricezioniEffettuate;
    }

    if (ricezioni == 0) return 0;

    return ((positive - negative) / ricezioni) * 100;
  }

  static double mediaPositivitaDifesa(List<Partita> partite) {
    int positive = 0;
    int difese = 0;

    for (final partita in partite) {
      positive += partita.difesa.difesePositive;
      difese += partita.difesa.difeseEffettuate;
    }

    if (difese == 0) return 0;

    return (positive / difese) * 100;
  }

  static double mediaEfficienzaDifesa(List<Partita> partite) {
    int positive = 0;
    int negative = 0;
    int difese = 0;

    for (final partita in partite) {
      positive += partita.difesa.difesePositive;
      negative += partita.difesa.difeseNegative;
      difese += partita.difesa.difeseEffettuate;
    }

    if (difese == 0) return 0;

    return ((positive - negative) / difese) * 100;
  }

  static double mediaBlockPercentuale(List<Partita> partite) {
    int muriPunto = 0;
    int muri = 0;

    for (final partita in partite) {
      muriPunto += partita.muro.muriPunto;
      muri += partita.muro.muriEffettuati;
    }

    if (muri == 0) return 0;

    return (muriPunto / muri) * 100;
  }
}