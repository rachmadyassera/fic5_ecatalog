part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final List<ProductResponseModel> data;
  final int offset;
  final int limit;
  final bool isNext;

  ProductsLoaded(
      {required this.data,
      this.offset = 0,
      this.limit = 10,
      this.isNext = false});
 
}

final class ProductsError extends ProductsState {
  final String message;

  ProductsError({required this.message});
}
