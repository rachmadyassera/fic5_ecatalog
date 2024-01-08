// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_ecatalog/data/datasources/product_datasources.dart';
import 'package:flutter_ecatalog/data/request/update_product_request_model.dart';
import 'package:flutter_ecatalog/data/response/update_product_response_model.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final ProductDataSources dataSource;
  UpdateProductBloc(
    this.dataSource,
  ) : super(UpdateProductInitial()) {
    on<DoUpdateProductEvent>((event, emit) async {
      emit(UpdateProductLoading());
      final result =
          await dataSource.updateProduct(event.model, event.productId);
      result.fold((l) => emit(UpdateProductError(message: l)),
          (r) => emit(UpdateProductLoaded(model: r)));
    });
  }
}
