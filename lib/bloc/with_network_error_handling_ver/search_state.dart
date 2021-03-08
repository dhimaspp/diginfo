import 'package:diginfo/error_handler/network_exceptions.dart';
import 'package:diginfo/model/artikel.dart';
import 'package:diginfo/model/model_response.dart';
import 'package:flutter/foundation.dart';
import 'package:diginfo/model_v2/artikel_response_v2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:diginfo/screens/component/search_screen.dart';

// part 'search_state.freezed.dart';

class SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  // final NetworkExceptions ne;
  // SearchError(this.ne);
}

class SearchNoTerm extends SearchState {}

class SearchPopulated extends SearchState {
  ArtikelResponse result;

  SearchPopulated(this.result);
}

class SearchEmpty extends SearchState {}
// @freezed
// abstract class SearchState<T> with _$SearchState<T> {
//   const factory SearchState.dataEmpty() = DataEmpty<T>;

//   const factory SearchState.loading() = Loading<T>;

//   const factory SearchState.data({@required T data}) = Data<T>;

//   const factory SearchState.error({@required NetworkExceptions error}) =
//       Error<T>;
// }
