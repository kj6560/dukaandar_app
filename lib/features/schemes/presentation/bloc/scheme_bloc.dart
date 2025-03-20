import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dukaandar/features/schemes/data/models/scheme_model.dart';
import 'package:dukaandar/features/schemes/data/repositories/scheme_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/config/config.dart';
import '../../../../core/local/hive_constants.dart';
import '../../../Auth/data/User.dart';

part 'scheme_event.dart';
part 'scheme_state.dart';

class SchemeBloc extends Bloc<SchemeEvent, SchemeState> {
  SchemeRepositoryImpl schemeRepositoryImpl = SchemeRepositoryImpl();
  SchemeBloc() : super(SchemeInitial()) {
    on<LoadSchemeList>(_loadScheme);
  }

  void _loadScheme(LoadSchemeList event, Emitter<SchemeState> emit) async {
    try {
      emit(LoadingSchemeList());
      String userString = await authBox.get(HiveKeys.userBox);
      String token = await authBox.get(HiveKeys.accessToken);
      User user = User.fromJson(jsonDecode(userString));
      print('user org id: ${user.orgId}');
      final response =
          await schemeRepositoryImpl.allSchemes(user.orgId!, token);
      if (response == null || response.data == null) {
        emit(LoadSchemeListFailure("No response from server"));
        return;
      }

      // Ensure data is always a Map<String, dynamic>
      final data = response.data['data'] is String
          ? jsonDecode(response.data['data'])
          : response.data['data'];
      print(data);
      final List<Scheme> schemeList = schemeFromJson(jsonEncode(data));

      if (response.statusCode == 401) {
        emit(LoadSchemeListFailure("Login failed."));
        return;
      }
      emit(LoadSchemeListSuccess(schemeList));
    } catch (e, stacktrace) {
      print('Exception in bloc: $e');
      print('Stacktrace: $stacktrace');
      emit(LoadSchemeListFailure("An error occurred."));
    }
    return;
  }
}
