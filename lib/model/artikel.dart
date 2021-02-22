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
