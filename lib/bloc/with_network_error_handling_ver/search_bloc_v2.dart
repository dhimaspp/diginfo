import 'package:diginfo/bloc/with_network_error_handling_ver/search_state.dart';
import 'package:diginfo/error_handler/api_repository.dart';
import 'package:diginfo/error_handler/api_result.dart';
import 'package:diginfo/error_handler/network_exceptions.dart';
import 'package:diginfo/model/artikel.dart';
import 'package:diginfo/repository/repository.dart';
import 'package:diginfo/model/model_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class GetSearchV2Bloc {
  final Sink<String> onTextChanged;
  final Stream<SearchState> state;

  factory GetSearchV2Bloc(ApiRepository api) {
    // ignore: close_sinks
    final onTextChanged = PublishSubject<String>();

    final state = onTextChanged
        .distinct()
        .debounceTime(const Duration(milliseconds: 250))
        // ignore: missing_return
        .switchMap<SearchState>(
            (String term) => _search(term, api).startWith(SearchNoTerm()));

    return GetSearchV2Bloc._(onTextChanged, state);
  }

  GetSearchV2Bloc._(this.onTextChanged, this.state);

  void dispose() {
    onTextChanged.close();
  }

  static Stream<SearchState> _search(String term, ApiRepository api) => term
          .isEmpty
      ? Stream.value(SearchNoTerm())
      : Rx.fromCallable(() => api.getSearch2(term)).map((result) => result.when(
            success: (ArtikelResponseV3 data) {
              SearchPopulated(data);
            },
            failure: (NetworkExceptions error) {
              SearchError(error);
            },
          )
              ? SearchEmpty()
              : SearchLoading());
}
