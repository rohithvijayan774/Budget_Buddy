import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management/main.dart';
import 'package:money_management/screens/first_screen.dart';
import 'package:money_management/widgets/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NameScreen extends StatelessWidget {
  NameScreen({super.key});
  final guestUser = 'Guest';
  final nameController = TextEditingController();
  final nameFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          width: 350,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 202, 200, 200),
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 20),
                  blurRadius: 10,
                  spreadRadius: 1)
            ],
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'MY MONEY',
                style: GoogleFonts.caveat(
                    textStyle: const TextStyle(fontSize: 50)),
                // style: TextStyle(
                //   fontSize: 40,
                //   fontWeight: FontWeight.bold,
                // ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter your name :',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: nameFormKey,
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: nameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          filled: true,
                          fillColor: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  textStyle: const TextStyle(fontSize: 18),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 130),
                  backgroundColor: const Color.fromARGB(255, 14, 69, 113),
                ),
                onPressed: () {
                  submitButtonClicked(context);
                  if (nameFormKey.currentState!.validate()) {}
                },
                child: const Text('SUBMIT'),
              ),
              TextButton(
                  onPressed: () {
                    guestButtonClicked(context);
                  },
                  child: const Text('Continue as guest'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submitButtonClicked(BuildContext context) async {
    final userName = nameController.text.toString();
    if (userName.isNotEmpty) {
      final sharedprefs = await SharedPreferences.getInstance();
      await sharedprefs.setString(SAVE_KEY_NAME, userName);

      log("${sharedprefs.getString(SAVE_KEY_NAME)}");

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const HomeScreen()));
    } else {
      return;
    }
  }

  Future<void> guestButtonClicked(BuildContext context) async {
    final guest = guestUser.toString();
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString(SAVE_KEY_NAME, guest);

    log("${sharedPref.getString(SAVE_KEY_NAME)}");

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const HomeScreen()));
  }
}
