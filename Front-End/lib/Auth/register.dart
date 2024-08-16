import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:freelancing/Screens/email_verfiction.dart';
import 'package:freelancing/Auth/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _ClientRegisterState();
}

Future Signup(
  String first_name,
  String last_name,
  String type,
  String email,
  String password,
  String password_confirmation,
  String birthdate,
  BuildContext context,
) async {
  var response = await http.post(
    Uri.parse('http://localhost:8000/api/register'),
    body: <String, String>{
      'first_name': first_name,
      'last_name': last_name,
      'type': type,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'birthdate': birthdate,
    },
  );

  if (response.statusCode == 200) {
    var js = jsonDecode(response.body);
     Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const LoginPage();
        },
      ),
    );
    String token = js['token'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const LoginPage();
        },
      ),
    );

    print('the token is $token');
  }
}

final registerTypeController = TextEditingController();
final registerEmailController = TextEditingController();
final registerPasswordController = TextEditingController();
final registerPasswordConfirmationController = TextEditingController();
final registerFirstNameController = TextEditingController();
final registerLastNameController = TextEditingController();
final registerBirthdateController = TextEditingController();

class _ClientRegisterState extends State<Register> {
  String? selectedType;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/Logo.png'),
                          fit: BoxFit.cover)),
                ),
                const SizedBox(height: 10),
                Text(
                  '4WORK',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Create an account',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: registerFirstNameController,
                  label: 'First Name',
                  context: context,
                ),
                _buildTextField(
                  controller: registerLastNameController,
                  label: 'Last Name',
                  context: context,
                ),
                _buildTextField(
                  controller: registerEmailController,
                  label: 'Email Address',
                  context: context,
                  keyboardType: TextInputType.emailAddress,
                ),
                _buildTextField(
                  controller: registerPasswordController,
                  label: 'Password',
                  context: context,
                  isPassword: true,
                ),
                _buildTextField(
                  controller: registerPasswordConfirmationController,
                  label: 'Confirm Password',
                  context: context,
                  isPassword: true,
                ),
                _buildDatePickerField(
                  controller: registerBirthdateController,
                  label: 'Birthdate',
                  context: context,
                ),
                const SizedBox(height: 10),
                Text(
                  'Select Type',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                const SizedBox(height: 10),
                _buildTypeSelectionRow(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedType != null) {
                          registerTypeController.text = selectedType!;
                        }
                        Signup(
                          registerFirstNameController.text,
                          registerLastNameController.text,
                          registerTypeController.text,
                          registerEmailController.text,
                          registerPasswordController.text,
                          registerPasswordConfirmationController.text,
                          registerBirthdateController.text,
                          context,
                        );
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
                  ),
                ),
                const SizedBox(height: 10),
                _buildContinueWithSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required BuildContext context,
    bool isPassword = false,
    IconData? icon,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
        decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          labelText: label,
          labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2.0,
            ),
          ),
          prefixIcon: icon != null ? Icon(icon) : null,
          prefixIconColor: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }

 Widget _buildDatePickerField({
  required TextEditingController controller,
  required String label,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: () async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData().copyWith(
              colorScheme: ColorScheme.light(
                primary: Theme.of(context).colorScheme.onSecondary,
                onPrimary: Theme.of(context).colorScheme.background,
                surface: Theme.of(context).colorScheme.onSurface,
                onSurface: Theme.of(context).colorScheme.background,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
              ),
              dialogBackgroundColor: Theme.of(context).colorScheme.background,
            ),
            child: child!,
          );
        },
      );

      if (pickedDate != null && pickedDate != selectedDate) {
        setState(() {
          selectedDate = pickedDate;
          controller.text = "${pickedDate.toLocal()}".split(' ')[0];
        });
      }
    },
    child: AbsorbPointer(
      child: _buildTextField(
        controller: controller,
        label: label,
        context: context,
      ),
    ),
  );
}

  Widget _buildTypeSelectionRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTypeButton('Freelancer', Icons.person_outline_outlined),
          _buildTypeButton('Client', Icons.person),
        ],
      ),
    );
  }

  Widget _buildTypeButton(String type, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = type.toLowerCase();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedType == type.toLowerCase()
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: selectedType == type.toLowerCase()
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(width: 8),
            Text(
              type,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: selectedType == type.toLowerCase()
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueWithSection(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account?',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginPage();
                    },
                  ),
                );
              },
              child: Text(
                'Sign in',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
