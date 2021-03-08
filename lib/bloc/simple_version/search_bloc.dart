import 'package:diginfo/repository/repository.dart';
import 'package:diginfo/model/model_response.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class GetSearchBloc {
  // final DiginfoRepository _diginfoRepository = DiginfoRepository();
  // final BehaviorSubject<ArtikelResponse> _subject =
  //     BehaviorSubject<ArtikelResponse>();
  GetSearchBloc({@required this.apiWrapper}) {
    _result = _subject
        .debounce((_) => TimerStream(true, Duration(milliseconds: 900)))
        .switchMap((query) async* {
      print("Searching: $query");
      yield await apiWrapper!.search(query);
    });
  }
  final DiginfoRepository? apiWrapper;
  final _subject = BehaviorSubject<String>();
  void search(String query) => _subject.add(query);

  late Stream<ArtikelResponse> _result;
  Stream<ArtikelResponse> get result => _result;

  void dispose() {
    _subject.close();
  }
}

final getSearchBloc = GetSearchBloc(apiWrapper: DiginfoRepository());
