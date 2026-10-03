import '../dati_inseribili/dati.dart';

class AnalizzatoreStatistiche {
  // =========================
  // ATTACCO
  // =========================

  static double calcolaKillPercentuale(DatiAttacchi dati) {
    if (dati.attacchiEffettuati == 0) {
      return 0;
    }

    return (dati.attacchiPunto / dati.attacchiEffettuati) * 100;
  }

  static double calcolaEfficienzaAttacco(DatiAttacchi dati) {
    if (dati.attacchiEffettuati == 0) {
      return 0;
    }

    return ((dati.attacchiPunto -
                dati.attacchiErrori -
                dati.attacchiMurati) /
            dati.attacchiEffettuati) *
        100;
  }

  static double calcolaErroreAttacco(DatiAttacchi dati) {
    if (dati.attacchiEffettuati == 0) {
      return 0;
    }

    return (dati.attacchiErrori / dati.attacchiEffettuati) * 100;
  }

  static double calcolaMuratoAttacco(DatiAttacchi dati) {
    if (dati.attacchiEffettuati == 0) {
      return 0;
    }

    return (dati.attacchiMurati / dati.attacchiEffettuati) * 100;
  }

  // =========================
  // BATTUTA
  // =========================

  static double calcolaAcePercentuale(DatiBattuta dati) {
    if (dati.battuteEffettuate == 0) {
      return 0;
    }

    return (dati.battutePunto / dati.battuteEffettuate) * 100;
  }

  static double calcolaErroreBattuta(DatiBattuta dati) {
    if (dati.battuteEffettuate == 0) {
      return 0;
    }

    return (dati.battuteErrori / dati.battuteEffettuate) * 100;
  }

  static double calcolaEfficienzaBattuta(DatiBattuta dati) {
    if (dati.battuteEffettuate == 0) {
      return 0;
    }

    return ((dati.battutePunto - dati.battuteErrori) /
            dati.battuteEffettuate) *
        100;
  }

  // =========================
  // RICEZIONE
  // =========================

  static double calcolaPositivitaRicezione(
    DatiRicezione dati,
  ) {
    if (dati.ricezioniEffettuate == 0) {
      return 0;
    }

    return (dati.ricezioniPositive /
            dati.ricezioniEffettuate) *
        100;
  }

  static double calcolaErroreRicezione(
    DatiRicezione dati,
  ) {
    if (dati.ricezioniEffettuate == 0) {
      return 0;
    }

    return (dati.ricezioniErrori /
            dati.ricezioniEffettuate) *
        100;
  }

  static double calcolaEfficienzaRicezione(
    DatiRicezione dati,
  ) {
    if (dati.ricezioniEffettuate == 0) {
      return 0;
    }

    return ((dati.ricezioniPositive -
                dati.ricezioniNegative) /
            dati.ricezioniEffettuate) *
        100;
  }

  // =========================
  // DIFESA
  // =========================

  static double calcolaPositivitaDifesa(
    DatiDifesa dati,
  ) {
    if (dati.difeseEffettuate == 0) {
      return 0;
    }

    return (dati.difesePositive /
            dati.difeseEffettuate) *
        100;
  }

  static double calcolaErroreDifesa(
    DatiDifesa dati,
  ) {
    if (dati.difeseEffettuate == 0) {
      return 0;
    }

    return (dati.difeseErrore /
            dati.difeseEffettuate) *
        100;
  }

  static double calcolaEfficienzaDifesa(
    DatiDifesa dati,
  ) {
    if (dati.difeseEffettuate == 0) {
      return 0;
    }

    return ((dati.difesePositive -
                dati.difeseNegative) /
            dati.difeseEffettuate) *
        100;
  }

  // =========================
  // MURO
  // =========================

  static double calcolaBlockPercentuale(
    DatiMuro dati,
  ) {
    if (dati.muriEffettuati == 0) {
      return 0;
    }

    return (dati.muriPunto / dati.muriEffettuati) * 100;
  }

  static double calcolaErroreMuro(
    DatiMuro dati,
  ) {
    if (dati.muriEffettuati == 0) {
      return 0;
    }

    return (dati.muriErrori / dati.muriEffettuati) * 100;
  }

  static double calcolaEfficienzaMuro(
    DatiMuro dati,
  ) {
    if (dati.muriEffettuati == 0) {
      return 0;
    }

    return ((dati.muriPunto - dati.muriErrori) /
            dati.muriEffettuati) *
        100;
  }

  // =========================
  // PUNTI
  // =========================

  static int calcolaPuntiTotali(Partita partita) {
    return partita.attacchi.attacchiPunto +
        partita.battuta.battutePunto +
        partita.muro.muriPunto;
  }

  // =========================
  // ERRORI TOTALI
  // =========================

  static int calcolaErroriTotali(Partita partita) {
    return partita.attacchi.attacchiErrori +
        partita.battuta.battuteErrori +
        partita.muro.muriErrori +
        partita.ricezione.ricezioniErrori +
        partita.difesa.difeseErrore;
  }
}