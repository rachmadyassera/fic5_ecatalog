// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ecatalog/data/datasources/auth_datasources.dart';
import 'package:flutter_ecatalog/data/request/register_request_model.dart';
import 'package:flutter_ecatalog/data/response/register_response_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthDatasource datasource;
  RegisterBloc(
    this.datasource,
  ) : super(RegisterInitial()) {
    on<DoRegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      //request register model ke data source, menunggu response
      final result = await datasource.register(event.model);
      result.fold(
        (l) => {
        // initial error bermakna nilai false atau error
        emit(RegisterError(message: l))
      }, (r) => {
        // initial sukses bermakna nilai true atau benar dan data diperoleh dari RegisterResponseModel
        emit (RegisterLoaded(model: r))
      });
 
 
    });
  }
}
