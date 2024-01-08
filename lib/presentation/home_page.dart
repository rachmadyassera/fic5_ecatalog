import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/bloc/add_product/add_product_bloc.dart';
import 'package:flutter_ecatalog/bloc/products/products_bloc.dart';
import 'package:flutter_ecatalog/bloc/update_product/update_product_bloc.dart';
import 'package:flutter_ecatalog/data/datasources/local_datasources.dart';
import 'package:flutter_ecatalog/data/request/product_request_model.dart';
import 'package:flutter_ecatalog/data/request/update_product_request_model.dart';
import 'package:flutter_ecatalog/presentation/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int productId;
  TextEditingController? titleController;
  TextEditingController? priceController;
  TextEditingController? descriptionController;

  @override
  void initState() {
    titleController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
    context.read<ProductsBloc>().add(GetProductsEvent());
  }

  @override
  void dispose() {
    super.dispose();
    titleController!.dispose();
    priceController!.dispose();
    descriptionController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        actions: [
          IconButton(
              onPressed: () async {
                await LocalDataSource().removeToken();
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const LoginPage();
                }));
              },
              icon: const Icon(Icons.logout)),
          const SizedBox(
            width: 16,
          )
        ],
        title: const Text('Home Page'),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
        if (state is ProductsLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  child: ListTile(
                    title:
                        Text(state.data.reversed.toList()[index].title ?? '-'),
                    subtitle: Text(
                        '${state.data.reversed.toList()[index].price} \$ - id : ${state.data.reversed.toList()[index].id}'),
                    onTap: () {
                      titleController!.text =
                          state.data.reversed.toList()[index].title!;
                      priceController!.text =
                          state.data.reversed.toList()[index].price!.toString();
                      descriptionController!.text =
                          state.data.reversed.toList()[index].description!;
                      productId = state.data.reversed.toList()[index].id!;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                                'Update Product ID : ${state.data.reversed.toList()[index].id}'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: titleController,
                                  decoration:
                                      InputDecoration(labelText: 'Title'),
                                ),
                                TextField(
                                  controller: priceController,
                                  decoration:
                                      InputDecoration(labelText: 'Price'),
                                ),
                                TextField(
                                  controller: descriptionController,
                                  decoration:
                                      InputDecoration(labelText: 'Description'),
                                  maxLines: 3,
                                )
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              BlocConsumer<UpdateProductBloc,
                                  UpdateProductState>(
                                listener: (context, state) {
                                  if (state is UpdateProductLoaded) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text(' Product has been Updated'),
                                      ),
                                    );
                                    context
                                        .read<ProductsBloc>()
                                        .add(GetProductsEvent());
                                    titleController!.clear();
                                    priceController!.clear();
                                    descriptionController!.clear();
                                    Navigator.pop(context);
                                  }
                                  if (state is UpdateProductError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Update Product ${state.message}'),
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is UpdateProductLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return ElevatedButton(
                                      onPressed: () {
                                        final model = UpdateProductRequestModel(
                                            title: titleController!.text,
                                            price: int.parse(
                                                priceController!.text),
                                            description:
                                                descriptionController!.text);

                                        context.read<UpdateProductBloc>().add(
                                            DoUpdateProductEvent(
                                                model: model,
                                                productId: productId));
                                      },
                                      child: const Text('Update'));
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
            itemCount: state.data.length,
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                
              titleController!.clear();
              priceController!.clear();
              descriptionController!.clear();
                return AlertDialog(
                  title: const Text('Add Product'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                      TextField(
                        controller: priceController,
                        decoration: InputDecoration(labelText: 'Price'),
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(labelText: 'Description'),
                        maxLines: 3,
                      )
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    BlocConsumer<AddProductBloc, AddProductState>(
                      listener: (context, state) {
                        if (state is AddProductLoaded) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Add Product Success'),
                            ),
                          );
                          context.read<ProductsBloc>().add(GetProductsEvent());
                          titleController!.clear();
                          priceController!.clear();
                          descriptionController!.clear();
                          Navigator.pop(context);
                        }
                        if (state is AddProductError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Add Product ${state.message}'),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AddProductLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ElevatedButton(
                            onPressed: () {
                              final model = ProductRequestModel(
                                  title: titleController!.text,
                                  price: int.parse(priceController!.text),
                                  description: descriptionController!.text);

                              context
                                  .read<AddProductBloc>()
                                  .add(DoAddProductEvent(model: model));
                            },
                            child: const Text('Add'));
                      },
                    ),
                  ],
                );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
