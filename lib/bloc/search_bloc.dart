import 'package:diginfo/repository/repository.dart';
import 'package:diginfo/model/model_response.dart';
import 'package:rxdart/rxdart.dart';

class GetSearchBloc {
  final DiginfoRepository _diginfoRepository = DiginfoRepository();
  final BehaviorSubject<ArtikelResponse> _subject =
      BehaviorSubject<ArtikelResponse>();

  getSearch(String query) async {
    ArtikelResponse response = await _diginfoRepository.search(query);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ArtikelResponse> get subject => _subject;
}

final getSearchBloc = GetSearchBloc();
