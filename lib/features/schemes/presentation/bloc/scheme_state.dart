part of 'scheme_bloc.dart';

@immutable
sealed class SchemeState {}

final class SchemeInitial extends SchemeState {}

class LoadingSchemeList extends SchemeState {}

class LoadSchemeListSuccess extends SchemeState {
  final List<Scheme> response;

  LoadSchemeListSuccess(this.response);
}

class LoadSchemeListFailure extends SchemeState {
  final String error;

  LoadSchemeListFailure(this.error);
}
