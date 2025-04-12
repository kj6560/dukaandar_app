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
    emit(LoginLoading()); // ✅ Emit loading state once

    try {
      print("📩 Logging in: ${event.email}");
      final response =
          await authRepositoryImpl.login(event.email, event.password);

      if (response == null || response.data == null) {
        print("a");
        emit(LoginFailure("No response from server"));
        return;
      }

      final data =
          response.data is String ? jsonDecode(response.data) : response.data;
      final loginResponse = Response.fromJson(data);

      if (loginResponse.statusCode == 200 && loginResponse.data != null) {
        final user = User.fromJson(loginResponse.data['user']);
        emit(LoginSuccess(user, loginResponse.data['token']));
      } else {
        // 🔥 Handle all error messages in one place
        final message = loginResponse.message ?? "Login failed.";
        print("b");
        emit(LoginFailure(message));
      }
    } catch (e, stacktrace) {
      print('❌ Exception in login bloc: $e');
      print('📌 Stacktrace: $stacktrace');
      print("c");
      emit(LoginFailure("An unexpected error occurred. Please try again."));
    }
  }
}
