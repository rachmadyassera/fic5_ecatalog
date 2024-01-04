import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: Text('Login User')),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(
              height: 16,
            ),

            // BlocConsumer<RegisterBloc, RegisterState>(builder: (context, state) {
            //       if (state is RegisterLoading) {
            //         return const Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       }
            //       return ElevatedButton(
            //           onPressed: () {
            //             final requestModel = RegisterRequestModel(
            //                 name: nameController!.text,
            //                 email: emailController!.text,
            //                 password: passwordController!.text);
            //             context
            //                 .read<RegisterBloc>()
            //                 .add(DoRegisterEvent(model: requestModel));
            //           },
            //           child: const Text('Register'));
            //     }, listener: (context, state) {
            //     if (state is RegisterError) {
            //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red,));
            //     }
            //     if (state is RegisterLoaded) {
            //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Register Success with name: ${state.model.name} - id: ${state.model.id}'), backgroundColor: Colors.green,));
            //       Navigator.push(context, MaterialPageRoute(builder: (context){
            //         return const LoginPage();
            //       }));
            //     }
            //   }),
          ],
        ),
      ),
    );
  }
}
