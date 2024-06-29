import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freelancing/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: userNameController,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: const Color.fromARGB(255, 110, 110, 110),
                  ),
              decoration: InputDecoration(
                hintText: ('USERNAME'),
                hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                enabledBorder: const UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: colorScheme.onSecondary,
                    width: 3.0,
                  ),
                ),
                prefixIcon: const Icon(CupertinoIcons.profile_circled),
                prefixIconColor: const Color.fromARGB(255, 110, 110, 110),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: passwordController,
              obscureText: _obscureText,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              decoration: InputDecoration(
                hintText: ('PASSWORD'),
                hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                enabledBorder: const UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: colorScheme.onSecondary,
                    width: 3.0,
                  ),
                ),
                prefixIcon: const Icon(Icons.lock),
                prefixIconColor: Theme.of(context).colorScheme.onBackground,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _toggleVisibility,
                ),
                suffixIconColor: Theme.of(context).colorScheme.onBackground,
              ),
            ),
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
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.onSurface),
                  ),
                  child: Text('Login',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.background,
                          )),
                ),
              )),
          Text(
            'or sign in with :',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          GestureDetector(
              onTap: () {},
              child: ClipOval(
                child: Image.asset(
                  'assets/images/Google Logo.jpg',
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              )),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text("Don't Have An Account",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        )),
              ),
              const SizedBox(
                width: 50,
              ),
              TextButton(
                onPressed: () {},
                child: Text("Forgot Password",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        )),
              ),
            ],
          )
        ],
      )),
    );
  }
}
