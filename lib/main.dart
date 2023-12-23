import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suit_media_test/data/datasources/auth_remote_datasource.dart';
import 'package:suit_media_test/presentation/login/bloc/palindrome/palindrome_bloc.dart';
import 'package:suit_media_test/presentation/login/pages/login_page.dart';
import 'package:suit_media_test/presentation/thirdscreen/bloc/fetch_user/fetch_user_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PalindromeBloc(),
        ),
        BlocProvider(
          create: (context) => FetchUserBloc(
            AuthRemoteDataSource(),
          ),
        ),
      ],
      child: MaterialApp(
          title: 'Suit Media Batch 6: Mobile Developer Intern 2023 ',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const LoginPage()),
    );
  }
}
