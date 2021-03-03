import 'package:diginfo/repository/repository.dart';
import 'package:diginfo/model/model_response.dart';
import 'package:rxdart/rxdart.dart';

class GetTopHeadlineGenBloc {
  final DiginfoRepository _diginfoRepository = DiginfoRepository();
  final BehaviorSubject<ArtikelResponse> _subject =
      BehaviorSubject<ArtikelResponse>();

  getTopHeadlinesGen() async {
    ArtikelResponse response = await _diginfoRepository.getTopHeadlinesGen();
    _subject.sink.add(response);
  }

  dispose() async {
    _subject.close();
  }

  BehaviorSubject<ArtikelResponse> get subject => _subject;
}

final getTopHeadlinesGen = GetTopHeadlineGenBloc();
