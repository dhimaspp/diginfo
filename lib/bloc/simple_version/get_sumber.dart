import 'package:diginfo/repository/repository.dart';
import 'package:diginfo/model/model_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class GetSumberBloc {
  final DiginfoRepository _diginfoRepository = DiginfoRepository();
  final BehaviorSubject<SumberResponse> _subject =
      BehaviorSubject<SumberResponse>();

  getSumber(String category) async {
    SumberResponse response = await _diginfoRepository.getSumber(category);
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

  BehaviorSubject<SumberResponse> get subject => _subject;
}

final getSumber = GetSumberBloc();
