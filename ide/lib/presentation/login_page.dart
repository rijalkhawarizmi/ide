import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ide/domain/shared/shared_cubit.dart';
import '../domain/auth/cubit/authentication_cubit.dart';
import '../widget/toast_widget.dart';
import 'home.dart';

class LoginPage extends StatelessWidget {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            context.read<SharedCubit>().checkIsUserLoggin();
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (c) {
              return const Home();
            }), (route) => false);
            toastWidget(state.message, Colors.greenAccent);
          } else if (state is AuthenticationFailed) {
            toastWidget(state.message, Colors.red);
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text(
                    'IDE',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Infra Digital Edukasi',
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          contentPadding: const EdgeInsets.all(16),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.greenAccent.shade400,
                                  width: 2)),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextField(
                            controller: password,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              contentPadding: const EdgeInsets.all(16),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.greenAccent.shade400,
                                      width: 2)),
                            )),
                        const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ))
                      ],
                    ),
                  )
                ],
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent.shade400,
                              minimumSize: const Size(double.infinity, 50)),
                          onPressed: () {
                            if (email.text.isEmpty) {
                              toastWidget('Masukkan Email', Colors.red);
                            } else if (password.text.isEmpty) {
                              toastWidget('Masukkan Password', Colors.red);
                            } else {
                              context.read<AuthenticationCubit>().login(
                                  email: email.text, password: password.text);
                            }
                          },
                          child: state is AuthenticationLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Sign In',
                                  style: TextStyle(fontSize: 20),
                                )),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Didn\'t have any account? Sign Up here',
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 15),
                        ),
                      )
                    ],
                  ))
            ],
          );
        },
      ),
    );
  }
}
