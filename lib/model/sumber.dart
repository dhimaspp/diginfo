class Sumber {
  final String? id;
  final String? namaSumber;
  final String? deskripsi;
  final String? url;
  final String? category;
  final String? negara;
  final String? language;

  Sumber(this.id, this.namaSumber, this.deskripsi, this.url, this.category,
      this.negara, this.language);

  Sumber.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        namaSumber = json["name"],
        deskripsi = json["description"],
        url = json["url"],
        category = json["category"],
        negara = json["country"],
        language = json["language"];
}
