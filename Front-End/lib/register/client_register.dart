import 'package:flutter/material.dart';
import 'package:freelancing/constant/colors.dart';


class clientRegister extends StatefulWidget {
  const clientRegister({super.key});

  @override
  State<clientRegister> createState() => _clientRegisterState();
}

class _clientRegisterState extends State<clientRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Image.asset(
                'assets/images/Logo.png',
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 15),
            Text(
              '4WORK',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40, fontWeight: FontWeight.w500, color: BlueGray),
            ),
            SizedBox(height: 20),
            Text(
              'Create an Client account',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500, color: IndigoDye),
            ),
            Text(
              'Enter your email to sign up for this app',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w500, color: IndigoDye),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 8),
              child: TextFormField(
                decoration: InputDecoration(
                  focusColor: Silver,
                  hintText: 'email@domain.com',
                  hintStyle: TextStyle(fontSize: 15, color: Silver),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: BlueGray),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 8),
              child: TextFormField(
                decoration: InputDecoration(
                  focusColor: Silver,
                  hintText: 'username',
                  hintStyle: TextStyle(fontSize: 15, color: Silver),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: BlueGray),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 8),
              child: TextFormField(
                decoration: InputDecoration(
                  focusColor: Silver,
                  hintText: 'password',
                  hintStyle: TextStyle(fontSize: 15, color: Silver),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: BlueGray),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 8),
              child: TextFormField(
                decoration: InputDecoration(
                  focusColor: Silver,
                  hintText: 'Re_password',
                  hintStyle: TextStyle(fontSize: 15, color: Silver),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: BlueGray),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: FloatingActionButton(
                onPressed: () {},
                child: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20, color: White),
                ),
                backgroundColor: Aquamarine,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'or countinu with',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Silver,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 10,
              ),
              child: FloatingActionButton(
                onPressed: () {},
                child: Image.asset(
                  'assets/images/google.png',
                  height: 30,
                  width: 30,
                ),
                backgroundColor: Silver,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
