import 'package:diginfo/repository/repository.dart';
import 'package:diginfo/model/model_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class GetSumberBeritaBloc {
  final DiginfoRepository _diginfoRepository = DiginfoRepository();
  final BehaviorSubject<ArtikelResponse> _subject =
      BehaviorSubject<ArtikelResponse>();

  getSumberBerita(String sumberId) async {
    ArtikelResponse response =
        await _diginfoRepository.getSumberBerita(sumberId);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.close();
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<ArtikelResponse> get subject => _subject;
}

final getSumberBeritaBloc = GetSumberBeritaBloc();
