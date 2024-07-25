import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelancing/Auth/login.dart';
import 'package:freelancing/main.dart';
import 'package:freelancing/Auth/register.dart';
import 'package:freelancing/Server/auth_service.dart';
import 'package:freelancing/tabs.dart';

class FreelancerRegister2 extends StatefulWidget {
  const FreelancerRegister2({super.key});

  @override
  State<FreelancerRegister2> createState() => _FreelancerRegisterState();
}

class _FreelancerRegisterState extends State<FreelancerRegister2> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final birthdayController = TextEditingController();
  final AuthService authService = AuthService();
  String userType = 'Freelancer';
  bool _obscureText = true;
  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _signUp() async {
  if (passwordController.text == rePasswordController.text) {
    bool success = await authService.register(
      firstNameController.text,
      lastNameController.text,
      userType,
      emailController.text,
      passwordController.text,
      rePasswordController.text,
      birthdayController.text,
    );

    if (success) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>const LoginPage()), 
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to register user',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
          ),
        ),
      );
    }
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


  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 100, now.month, now.day);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Theme.of(context).colorScheme.surface,
              onSurface: Theme.of(context).colorScheme.onSurface,
            ),
            dialogBackgroundColor: Theme.of(context).colorScheme.background,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        birthdayController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    emailController.dispose();
    birthdayController.dispose();
    super.dispose();
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
                  controller: firstNameController,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: colorScheme.onBackground,
                      ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ('First Name'),
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
                  controller: lastNameController,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: colorScheme.onBackground,
                      ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ('Last Name'),
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
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: DropdownButtonFormField<String>(
                    value: userType,
                    decoration: InputDecoration(
                      labelText: 'User Type',
                      labelStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.5), // Label color
                      ),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                      prefixIcon: const Icon(Icons.supervised_user_circle),
                      prefixIconColor: const Color.fromARGB(255, 110, 110, 110),
                      border: InputBorder.none,
                    ),
                    items: <String>['Freelancer', 'Client'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .primary, // Customize text color here
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        userType = newValue!;
                      });
                    },
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground, // Selected item color
                    ),
                    dropdownColor: Theme.of(context)
                        .colorScheme
                        .onSecondary, // Background color of the dropdown
                    iconEnabledColor: Theme.of(context)
                        .colorScheme
                        .onBackground, // Arrow icon color
                    iconDisabledColor: Theme.of(context)
                        .colorScheme
                        .onBackground, // Disabled icon color
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
                  controller: birthdayController,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: colorScheme.onBackground,
                      ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ('Birthday'),
                    hintStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.5),
                            ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.9),
                      ),
                      onPressed: () => _selectDate(context),
                    ),
                    prefixIconColor: const Color.fromARGB(255, 110, 110, 110),
                  ),
                  readOnly: true,
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
                    onPressed: _signUp,
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
