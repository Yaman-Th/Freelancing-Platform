import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor:Theme.of(context).colorScheme.background,
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
                      backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.onSurface),
                    ),
                    child: Text('Login',
                         style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      )),
                  ),
                )),
            Text(
              'or sign in with :',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.g_mobiledata,
              ),
              style:
                  IconButton.styleFrom(iconSize: 50, foregroundColor:Theme.of(context).colorScheme.onSurface ),
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Don't Have An Account",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      )
                      ),
                    ),
                    const SizedBox(width:50,),
                     TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      )
                    ),),
              ],
                    )
      ],
      )),
      );
  }
}
