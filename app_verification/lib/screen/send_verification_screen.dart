import '../modals/functions.dart';
import '../screen/verification_screen.dart';
import '../widget/TextCenter.dart';
import 'package:flutter/material.dart';

class SendVerificationScreen extends StatefulWidget {
  const SendVerificationScreen({Key? key}) : super(key: key);

  @override
  State<SendVerificationScreen> createState() => _SendVerificationScreenState();
}

class _SendVerificationScreenState extends State<SendVerificationScreen> {
  String phone = "0548888884";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TextCenter(
              text: 'קוד אימות',
              margin: 30,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            const TextCenter(
              text: 'שלחנו הודעה עם קוד חד פעמי לטלפון הנייד שלך',
            ),
            TextCenter(
              text: '${phone.substring(0, 3)}-****${phone.substring(7)}',
              fontSize: 30,
            ),
            Container(
              width: 250,
              margin: const EdgeInsets.only(bottom: 40),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).primaryColor),
              child: TextButton(
                child: const Text(
                  'שליחת קוד אימות',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  var code = sendVerificationCode(phone);
                  print('code $code');
                  Navigator.pushNamed(context, VerificationScreen.routeName,
                      arguments: {'phone': phone, 'verificationCode': code});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
