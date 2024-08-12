import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testeeeer/colors.dart';

class FreelancerEmailVerification extends StatefulWidget {
  const FreelancerEmailVerification({super.key});

  @override
  State<FreelancerEmailVerification> createState() =>
      _FreelancerEmailVerificationState();
}

Future<void> verification(String token, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token2 = prefs.getString('first_token');
  var response = await http.post(
    Uri.parse('http://192.168.2.5:8000/api/verify-email'),
    headers: {
      'Authorization': 'Bearer $token2',
    },
    body: <String, String>{
      'token': token,
    },
  );

  if (response.statusCode == 200) {
    var js = jsonDecode(response.body);
    String token1 = js['token'];
    print('The token is $token1');

    // Save the token to shared preferences

    // Navigate to another screen if needed
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return Login();
    // }));
  } else {
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
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
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
                      controller: second,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
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
                      controller: third,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
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
                      controller: fourth,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
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
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
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
                      controller: sixth,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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
              },
              child: const Text(
                'Submit',
                //            style: TextStyle(fontSize: 20, color: White),
              ),
              backgroundColor: Aquamarine,
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
