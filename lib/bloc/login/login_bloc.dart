// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_ecatalog/data/request/login_request_model.dart';
import 'package:meta/meta.dart';

import 'package:flutter_ecatalog/data/datasources/auth_datasources.dart';
import 'package:flutter_ecatalog/data/response/login_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthDatasource datasource;

  LoginBloc(
    this.datasource,
  ) : super(LoginInitial()) {
    on<DoLoginEvent>((event, emit) async {
      emit(LoginLoading());
      final result = await datasource.login(event.model);
      result.fold(
        (l) => emit(LoginError(message: l)),
        (r) => emit(LoginLoaded(model: r)),
      );
    });
  }
}
