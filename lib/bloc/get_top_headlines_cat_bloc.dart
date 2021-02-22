import 'package:diginfo/repository/repository.dart';
import 'package:diginfo/model/model_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class GetTopHeadlinesCatBloc {
  final DiginfoRepository _diginfoRepository = DiginfoRepository();
  final BehaviorSubject<ArtikelResponse> _subject =
      BehaviorSubject<ArtikelResponse>();

  getTopHeadlinesCat(String category) async {
    ArtikelResponse response =
        await _diginfoRepository.getTopHeadlinesCat(category);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<ArtikelResponse> get subject => _subject;
}

final getTopHeadlinesCatBloc = GetTopHeadlinesCatBloc();
