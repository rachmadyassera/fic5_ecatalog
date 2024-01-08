part of 'update_product_bloc.dart';

@immutable
sealed class UpdateProductEvent {}

class DoUpdateProductEvent extends UpdateProductEvent {
  final UpdateProductRequestModel model;
  final int productId;

  DoUpdateProductEvent({required this.model, required this.productId});
}
