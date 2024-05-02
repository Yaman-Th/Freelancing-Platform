import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:freelancing/main.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/sign up image.jpg', height: 300),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Sign in',
              style: GoogleFonts.lato(
                color: color1,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: userNameController,
              decoration: const InputDecoration(
                hintText: ('USERNAME'),
                prefixIcon: Icon(CupertinoIcons.profile_circled),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: ('PASSWORD'), prefixIcon: Icon(Icons.lock)),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(color1),
                    ),
                    child: Text('Login',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          color: Colors.white,
                        )),
                  ),
                )),
            Text(
              'or sign in with :',
              style: GoogleFonts.lato(
                fontSize: 16,
                color: color1,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.g_mobiledata,
              ),
              style:
                  IconButton.styleFrom(iconSize: 50, foregroundColor: color1),
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Don't Have An Account",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: color1,
                      ),
                    ),),
                    const SizedBox(width:50,),
                     TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: color1,
                      ),
                    ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
