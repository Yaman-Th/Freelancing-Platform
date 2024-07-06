import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelancing/main.dart';
import 'package:freelancing/Auth/register.dart';
import 'package:freelancing/Auth/auth_service.dart';
import 'package:freelancing/tabs.dart';

class FreelancerRegister extends StatefulWidget {
  const FreelancerRegister({super.key});

  @override
  State<FreelancerRegister> createState() => _FreelancerRegisterState();
}

class _FreelancerRegisterState extends State<FreelancerRegister> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final rePasswordController = TextEditingController();
  final AuthService authService = AuthService();
  bool _obscureText = true;
  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _signUp() async {
    if (passwordController.text == rePasswordController.text) {
      await authService.register(
        userNameController.text,
        emailController.text,
        passwordController.text,
        rePasswordController.text,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Passwords do not match!',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Register()));
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        toolbarHeight: 30,
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
              'Create an freelancer account',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            Text(
              'Enter your email to sign up for this app',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                margin: const EdgeInsets.all(10),
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
                    hintStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
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
                margin: const EdgeInsets.all(10),
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
                  controller: userNameController,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: colorScheme.onBackground,
                      ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ('username'),
                    hintStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
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
                margin: const EdgeInsets.all(10),
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
                    hintStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
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
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                margin: const EdgeInsets.all(10),
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
                  controller: rePasswordController,
                  obscureText: _obscureText,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ('Re-Password'),
                    hintStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
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
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text('Sign Up',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
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
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
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
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            )),
                    const TextSpan(text: ' and '),
                    TextSpan(
                        text: 'Privacy Policy',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            )),
                  ],
                ),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
