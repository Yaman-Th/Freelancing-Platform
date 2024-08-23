import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancing/constant/colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freelancing/Auth/login.dart';

class FreelancerEmailVerification extends StatefulWidget {
  const FreelancerEmailVerification({super.key});

  @override
  State<FreelancerEmailVerification> createState() =>
      _FreelancerEmailVerificationState();
}

Future<void> verification(String code, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  var response = await http.post(
    Uri.parse('http://localhost:8000/api/verify-email'),
    headers: {
      'Authorization': 'Bearer $token',
    },
    body: <String, String>{
      'code': code,
    },
  );

  if (response.statusCode == 200) {
    var js = jsonDecode(response.body);
    String token = js['token'];
    print('The token is $token');

    // Save the token to shared preferences

    // Navigate to another screen if needed
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return Login();
    // }));
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return LoginScreen();
    //     },
    //   ),
    // );
  } else {
    print(
      first.text +
          second.text +
          third.text +
          fourth.text +
          fifth.text +
          sixth.text,
    );
    print('Verification failed');
  }
}

final first = TextEditingController();
final second = TextEditingController();
final third = TextEditingController();
final fourth = TextEditingController();
final fifth = TextEditingController();
final sixth = TextEditingController();

class _FreelancerEmailVerificationState
    extends State<FreelancerEmailVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Image.asset(
              'assets/images/Logo.png',
              height: 100,
              width: 100,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Email Verification',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: BlueGray,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'We have sent you the code to your email',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: IndigoDye,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Check your inbox',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                //     color: IndigoDye,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: TextFormField(
                      controller: first,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                      //keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: TextFormField(
                      controller: second,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                      //   keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: TextFormField(
                      controller: third,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                      //keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: TextFormField(
                      controller: fourth,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                      //  keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: TextFormField(
                      controller: fifth,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                      //  keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: TextFormField(
                      controller: sixth,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                      // keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
            child: FloatingActionButton(
              onPressed: () {
                verification(
                  first.text +
                      second.text +
                      third.text +
                      fourth.text +
                      fifth.text +
                      sixth.text,
                  context,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
              backgroundColor: Aquamarine,
              child: const Text(
                'Submit',
                //            style: TextStyle(fontSize: 20, color: White),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Text(
            'If you do not receive the email',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: IndigoDye,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100, right: 100),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Resend',
                // style: TextStyle(fontSize: 20, color: Aquamarine),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
