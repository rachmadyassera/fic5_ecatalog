import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecatalog/data/request/product_request_model.dart';
import 'package:flutter_ecatalog/data/request/update_product_request_model.dart';
import 'package:flutter_ecatalog/data/response/product_response_model.dart';
import 'package:flutter_ecatalog/data/response/update_product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductDataSources {
  Future<Either<String, List<ProductResponseModel>>> getAllProduct() async {
    final response =
        await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products/'));

    if (response.statusCode == 200) {
      return Right(
        List<ProductResponseModel>.from(
          jsonDecode(response.body).map(
            (x) => ProductResponseModel.fromMap(x),
          ),
        ),
      );
    } else {
      return const Left('get product error');
    }
  }

  Future<Either<String, ProductResponseModel>> createProduct(
      ProductRequestModel model) async {
    final response = await http.post(
        Uri.parse('https://api.escuelajs.co/api/v1/products/'),
        body: model.toJson(),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('error add product');
    }
  }

  Future<Either<String, UpdateProductResponseModel>> updateProduct(
      UpdateProductRequestModel model, productId) async {
    final response = await http.put(
        Uri.parse('https://api.escuelajs.co/api/v1/products/$productId'),
        body: {
          "title": model.title,
          "price": model.price.toString(),
          "description": model.description
        });
    debugPrint(
      'result resposne from sever : ${jsonDecode(response.body).toString()} ${response.statusCode}',
    );

    if (response.statusCode == 200) {
      return Right(UpdateProductResponseModel.fromJson(response.body));
    } else {
      return const Left('update product is Error');
    }
  }

  Future<Either<String, List<ProductResponseModel>>> getPaginationProduct(
      {required int offset, required int limit}) async {
    final response = await http.get(Uri.parse(
        'https://api.escuelajs.co/api/v1/products/?offset=$offset&limit=$limit'));
// https://api.escuelajs.co/api/v1/products/?offset=0&limit=10
  
    if (response.statusCode == 200) {
      return Right(
        List<ProductResponseModel>.from(
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
