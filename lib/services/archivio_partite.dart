import '../dati_inseribili/dati.dart';
import 'archivio_stagioni.dart';

List<Partita> get archivioPartite {
  return ArchivioStagioni.stagioneAttiva.partite;
}