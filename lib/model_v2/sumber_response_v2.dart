import 'package:diginfo/model/sumber.dart';

class SumberResponseV2 {
  String? status;
  List<Sumber>? sumber;

  SumberResponseV2(this.sumber, this.status);

  SumberResponseV2.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['sources'] != null) {
      sumber = <Sumber>[];
      json['sources'].forEach((v) {
        sumber!.add(new Sumber.fromJson(v));
      });
    }
  }
}
