import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suit_media_test/core/assets/assets.gen.dart';
import 'package:suit_media_test/core/components/buttons.dart';
import 'package:suit_media_test/presentation/login/bloc/palindrome/palindrome_bloc.dart';
import 'package:suit_media_test/presentation/login/widgets/custom_text_field.dart';
import 'package:suit_media_test/presentation/secondscreen/pages/second_screen_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nameC = TextEditingController();
  final TextEditingController palindromeC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //make body with image background
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.background.path),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(33),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  Assets.photo.path,
                  height: 116,
                  width: 116,
                ),
              ),
              const SizedBox(height: 51),
              CustomTextField(
                controller: nameC,
                label: "Name",
                obscureText: false,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: palindromeC,
                label: "Palindrome",
                obscureText: false,
              ),
              const SizedBox(height: 45),
              BlocConsumer<PalindromeBloc, PalindromeState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    success: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Button(
                          onPressed: () {
                            if (palindromeC.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Input PalindromeC Empty"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              context.read<PalindromeBloc>().add(
                                    PalindromeEvent.checkPalindrome(
                                      palindromeC.text,
                                    ),
                                  );
                            }
                          },
                          label: "CHECK",
                          height: 41);
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 15),
              Button(
                  onPressed: () {
                    if (nameC.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Input Name Empty"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SecondScreen(name: nameC.text),
                        ),
                      );
                    }
                  },
                  label: "NEXT",
                  height: 41),
            ],
          ),
        ),
      ),
    );
  }
}
