import 'package:diginfo/model/sumber.dart';

class Artikel {
  final Sumber sumber;
  final String penulis;
  final String judul;
  final String deskripsi;
  final String url;
  final String img;
  final String date;
  final String content;

  Artikel(this.sumber, this.penulis, this.judul, this.deskripsi, this.url,
      this.img, this.date, this.content);

  Artikel.fromJson(Map<String, dynamic> json)
      : sumber = Sumber.fromJson(json["source"]),
        penulis = json["author"],
        judul = json["title"],
        deskripsi = json["description"],
        url = json["url"],
        img = json["urlToImage"],
        date = json["publishedAt"],
        content = json["content"];
}

class ArtikelResponseV3 {
  final List<Artikel> artikel;

  ArtikelResponseV3(this.artikel);

  factory ArtikelResponseV3.fromJson(dynamic json) {
    final artikel = (json as List)
        .cast<Map<String, Object>>()
        .map((Map<String, Object> artikel) {
      return Artikel.fromJson(artikel);
    }).toList();

    return ArtikelResponseV3(artikel);
  }

  bool get isPopulated => artikel.isNotEmpty;

  bool get isEmpty => artikel.isEmpty;
}
