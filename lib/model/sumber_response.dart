import 'package:diginfo/model/sumber.dart';

class SumberResponse {
  final List<Sumber> sumber;
  final String error;

  SumberResponse(this.sumber, this.error);

  SumberResponse.fromJson(Map<String, dynamic> json)
      : sumber = (json["sources"] as List)
            .map((i) => new Sumber.fromJson(i))
            .toList(),
        error = "";

  SumberResponse.withError(String errorValue)
      : sumber = [],
        error = errorValue;
}
