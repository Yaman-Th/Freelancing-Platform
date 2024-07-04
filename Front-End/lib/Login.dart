import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelancing/auth_service.dart';
import 'package:freelancing/main.dart';
import 'package:freelancing/register.dart';
import 'package:freelancing/tabs.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  final AuthService authService = AuthService();

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _login() async {
    await authService.login(
      emailController.text,
      passwordController.text,
    );
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
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/images/Short_Logo.png'),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '4Work',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Welcome Back our Freelancer',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: colorScheme.background,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.onBackground.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: TextField(
                controller: emailController,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: colorScheme.onBackground,
                    ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: ('email@domain.com'),
                  hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.5),
                      ),
                  prefixIcon: const Icon(CupertinoIcons.profile_circled),
                  prefixIconColor: const Color.fromARGB(255, 110, 110, 110),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: colorScheme.background,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.onBackground.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: TextField(
                controller: passwordController,
                obscureText: _obscureText,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: ('Password'),
                  hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.5),
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
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: 370,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const TabsScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text('Login',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.background,
                          )),
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('or continue with',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
              ),
              const Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 350,
              height: 45,
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Google_Logo.png',
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Google',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text.rich(
                  TextSpan(
                    text: 'By clicking continue, you agree to our ',
                    children: [
                      TextSpan(
                          text: 'Terms of Service',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              )),
                      const TextSpan(text: ' and '),
                      TextSpan(
                          text: 'Privacy Policy',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              )),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const Register())));
                  },
                  child: Text(
                    "Don't Have An Account",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 18),
                  ),
                ),
              ),
              Flexible(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
