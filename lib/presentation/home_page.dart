import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/bloc/products/products_bloc.dart';
import 'package:flutter_ecatalog/data/datasources/local_datasources.dart';
import 'package:flutter_ecatalog/presentation/login_page.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(GetProductsEvent());
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
                    title: Text(state.data[index].title ?? '-'),
                    subtitle: Text('${state.data[index].price} \$'),
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
    );
  }
}