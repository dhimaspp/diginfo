import 'package:diginfo/model/artikel.dart';

class ArtikelResponseV2 {
  String status;
  int totalResults;
  List<Artikel> artikel;

  ArtikelResponseV2(this.artikel, this.status, this.totalResults);

  ArtikelResponseV2.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      artikel = new List<Artikel>();
      json['articles'].forEach((v) {
        artikel.add(new Artikel.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['totalResults'] = this.totalResults;
  //   if (this.artikel != null) {
  //     data['articles'] = this.artikel.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}
