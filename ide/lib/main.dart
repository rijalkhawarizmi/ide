import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ide/domain/auth/cubit/authentication_cubit.dart';
import 'package:ide/domain/fetch/cubit/fetch_cubit.dart';
import 'package:ide/root.dart';


import 'domain/shared/shared_cubit.dart';

void main() async{
  // await initializeTimeZone();
   // Get the current date and time in UTC
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (c)=>AuthenticationCubit()),
        BlocProvider(create: (c)=>FetchCubit()),
        BlocProvider(create: (c)=>SharedCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Root()
      ),
    );
  }
}

