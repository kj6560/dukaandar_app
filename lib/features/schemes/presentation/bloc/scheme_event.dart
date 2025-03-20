part of 'scheme_bloc.dart';

abstract class SchemeEvent extends Equatable {
  const SchemeEvent();

  @override
  List<Object> get props => [];
}

class LoadSchemeList extends SchemeEvent {
  const LoadSchemeList();
}
