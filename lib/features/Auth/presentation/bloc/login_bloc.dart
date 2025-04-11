import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/Dio/auth/DioRepo.dart';
import '../../data/User.dart';
import '../../data/login_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_loginToServer);
    on<LoginButtonClicked>(_loginClicked);
    on<LoginReset>((event, emit) {
      emit(LoginInitial());
    });
  }

  _loginClicked(LoginButtonClicked event, Emitter<LoginState> emit) {
    emit(LoginLoading());
    return;
  }

  Future<void> _loginToServer(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      print("${event.email}");
      final response =
          await authRepositoryImpl.login(event.email, event.password);
      if (response == null || response.data == null) {
        emit(LoginFailure("No response from server"));
        return;
      }
      final data =
          response.data is String ? jsonDecode(response.data) : response.data;
      final loginResponse = Response.fromJson(data);
      if (loginResponse.statusCode == 400 || loginResponse.statusCode == 500) {
        emit(LoginFailure("Login failed."));
        return;
      }
      if (loginResponse.statusCode == 401) {
        emit(LoginFailure(loginResponse.data['error']));
      }
      if (loginResponse.data != null) {
        if (loginResponse.statusCode == 200) {
          User user = User.fromJson(loginResponse.data['user']);
          emit(LoginSuccess(user, loginResponse.data['token']));
        } else if (loginResponse.statusCode == 202) {
          emit(LoginFailure(loginResponse.message));
        }
      } else {
        emit(LoginFailure("No user found for the given credentials."));
      }
    } catch (e, stacktrace) {
      print('Exception in bloc: $e');
      print('Stacktrace: $stacktrace');
      emit(LoginFailure("An error occurred."));
    }
  }
}
