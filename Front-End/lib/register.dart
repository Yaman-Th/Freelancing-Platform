import 'package:flutter/material.dart';
import 'package:freelancing/client_register.dart';
import 'package:freelancing/freelancer_register.dart';
import 'package:freelancing/login.dart';
import 'package:freelancing/main.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset('assets/images/Full_Logo.png'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '4Work App',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 60),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Welcome To our App',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'please choose what are you doing',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  focusColor: colorScheme.onSecondary,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FreelancerRegister()));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 60,
                  color: colorScheme.onSecondary,
                  textColor: colorScheme.background,
                  child: Text(
                    'Freelancer',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  focusColor: colorScheme.onSecondary,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ClientRegister()));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 60,
                  // minWidth: 100,
                  color: colorScheme.onSecondary,
                  textColor: colorScheme.background,
                  child: Text(
                    'Client',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>const LoginPage()));
                    },
                    child: Text(
                      'skip',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
