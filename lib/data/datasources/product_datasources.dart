import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_ecatalog/data/response/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductDataSources {
  Future<Either<String, List<ProductResponseModel>>> getAllProduct() async {
    final response =
        await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products/'));

    if (response.statusCode == 200) {
      return Right(
        List.from(
          jsonDecode(response.body).map(
            (x) => ProductResponseModel.fromMap(x),
          ),
        ),
      );
    } else {
      return const Left('get product error');
    }
  }
}
