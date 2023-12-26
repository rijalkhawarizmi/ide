import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ide/presentation/home.dart';
import 'package:ide/presentation/login_page.dart';

import 'domain/shared/shared_cubit.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SharedCubit>(context).checkIsUserLoggin();
    return BlocConsumer<SharedCubit, SharedState>(
      listener: (context, state) {
        if (state is NotLoggeIn) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) {
            return LoginPage();
          }), (route) => false);
        } else if (state is LoggeIn) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) {
            return const Home();
          }), (route) => false);
        }
      },
      builder: (context, state) {
        return Container(
          color: Colors.transparent,
        );
      },
    );
  }
}
