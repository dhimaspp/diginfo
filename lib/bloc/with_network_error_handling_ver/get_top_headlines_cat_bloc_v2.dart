// import 'package:diginfo/error_handler/api_repository.dart';
// import 'package:diginfo/model_v2/artikel_response_v2.dart';
// import 'package:diginfo/repository/repository.dart';
// import 'package:diginfo/model/model_response.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:rxdart/rxdart.dart';

// class GetTopHeadlinesCatBloc {
//   final ApiRepository _apiRepository = ApiRepository();
//   final BehaviorSubject<ArtikelResponseV2> _subject =
//       BehaviorSubject<ArtikelResponseV2>();

//   getTopHeadlinesCat2(String category) async {
//     ArtikelResponseV2 response =
//         await _apiRepository.getTopHeadlinesCat2(category);
//     _subject.sink.add(response);
//   }

//   void drainStream() {
//     _subject.value = null;
//   }

//   @mustCallSuper
//   void dispose() async {
//     await _subject.drain();
//     _subject.close();
//   }

//   BehaviorSubject<ArtikelResponse> get subject => _subject;
// }

// final getTopHeadlinesCatBloc = GetTopHeadlinesCatBloc();
