import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancing/chat/freelancer_chat.dart';
import 'package:freelancing/constant/colors.dart';


class freelanceremailverifiction extends StatefulWidget {
  const freelanceremailverifiction({super.key});

  @override
  State<freelanceremailverifiction> createState() =>
      _freelanceremailverifictionState();
}

class _freelanceremailverifictionState
    extends State<freelanceremailverifiction> {
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
          SizedBox(height: 15),
          Text(
            'Email verifiction',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.w500, color: BlueGray),
          ),
          SizedBox(height: 20),
          Text(
            'We have sent you the code to your email',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: IndigoDye),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Check your inbox',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w500, color: IndigoDye),
            ),
          ),
          SizedBox(
            height: 40,
          ),
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
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: TextFormField(
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
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: TextFormField(
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
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: TextFormField(
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
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: TextFormField(
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
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: TextFormField(
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
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ChatListScreen()));
              },
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 20, color: White),
              ),
              backgroundColor: Aquamarine,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'If you do not receive the email',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: IndigoDye),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100, right: 100),
            child: TextButton(
                onPressed: () {},
                child: Text(
                  'Resend',
                  style: TextStyle(fontSize: 20, color: Aquamarine),
                )),
          )
        ],
      ),
    );
  }
}
