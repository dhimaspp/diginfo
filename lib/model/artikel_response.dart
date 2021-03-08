import 'package:diginfo/model/artikel.dart';

class ArtikelResponse {
  final List<Artikel> artikel;
  final String error;

  ArtikelResponse(this.artikel, this.error);

  ArtikelResponse.fromJson(Map<String, dynamic> json)
      : artikel = (json["articles"] as List)
            .map((i) => new Artikel.fromJson(i))
            .toList(),
        error = "";

  ArtikelResponse.withError(String errorValue)
      : artikel = [],
        error = errorValue;
}
