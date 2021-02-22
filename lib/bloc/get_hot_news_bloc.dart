import 'package:diginfo/repository/repository.dart';
import 'package:diginfo/model/model_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class GetHotNewsBloc {
  final DiginfoRepository _diginfoRepository = DiginfoRepository();
  final BehaviorSubject<ArtikelResponse> _subject =
      BehaviorSubject<ArtikelResponse>();

  getHotNews(String query) async {
    ArtikelResponse response = await _diginfoRepository.getHotNews(query);
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

final getHotNewsBloc = GetHotNewsBloc();
