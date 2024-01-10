// ignore_for_file: public_member_api_docs, sort_constructors_first, unrelated_type_equality_checks
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:flutter_ecatalog/data/datasources/product_datasources.dart';
import 'package:flutter_ecatalog/data/response/product_response_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductDataSources dataSource;
  ProductsBloc(
    this.dataSource,
  ) : super(ProductsInitial()) {
    on<GetProductsEvent>((event, emit) async {
      emit(ProductsLoading());
      final result =
          await dataSource.getPaginationProduct(offset: 0, limit: 10);
      result.fold(
        (l) => emit(
          ProductsError(message: l),
        ),
        (r) {
          bool isNext = r.length == 10;
          emit(
            ProductsLoaded(data: r, isNext: isNext),
          );
        },
      );
    });

    on<NextProductsEvent>((event, emit) async {
      final currentState = state as ProductsLoaded;
      final result = await dataSource.getPaginationProduct(
          offset: currentState.offset + 10, limit: 10);
      result.fold(
        (l) => emit(
                ProductsError(message: l),
              ), (r) {
          bool isNext = r.length == 10;
          // debugPrint(isNext.toString());
        emit(ProductsLoaded(
            data: [...currentState.data, ...r],
            offset: currentState.offset + 10,
            isNext: isNext));
        },
      );
    });
  }
}
