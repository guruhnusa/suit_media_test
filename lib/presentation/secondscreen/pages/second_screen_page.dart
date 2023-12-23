import 'package:flutter/material.dart';

import 'package:suit_media_test/core/components/buttons.dart';
import 'package:suit_media_test/core/constraint/colors.dart';
import 'package:suit_media_test/presentation/login/pages/login_page.dart';
import 'package:suit_media_test/presentation/thirdScreen/pages/third_screen_page.dart';

class SecondScreen extends StatefulWidget {
  final String? name;
  final String? user;
  const SecondScreen({
    Key? key,
    this.name,
    this.user,
  }) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Second Screen',
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const LoginPage();
            }));
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF554AF0),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    widget.name!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                'Selected ${widget.user ?? "User Name"}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Button(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThirdScreen(name: widget.name!),
                    ),
                  );
                },
                label: "Choose a User",
                height: 41)
          ],
        ),
      ),
    );
  }
}
