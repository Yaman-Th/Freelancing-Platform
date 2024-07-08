import 'package:flutter/material.dart';
import 'package:freelancing/constant/colors.dart';
import 'package:freelancing/email_verifiction/freelancer_lvereificion.dart';


class freelancerlogin extends StatefulWidget {
  const freelancerlogin({super.key});

  @override
  State<freelancerlogin> createState() => _freelancerloginState();
}

class _freelancerloginState extends State<freelancerlogin> {
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
              'Welcome back our freelancer',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500, color: IndigoDye),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 50),
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
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 50),
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
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => freelanceremailverifiction()));
                },
                child: Text(
                  'Log in',
                  style: TextStyle(fontSize: 20, color: White),
                ),
                color: Aquamarine,
              ),
            ),
            SizedBox(
              height: 20,
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
                top: 30,
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
