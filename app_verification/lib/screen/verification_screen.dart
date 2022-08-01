import '../modals/functions.dart';
import '../screen/after_verification_screen.dart';
import '../widget/CountDownProgressIndicator.dart';
import '../widget/TextCenter.dart';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  static const routeName = '/verification';

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool hasError = false;
  bool isButtonEnabled = false;
  bool isTimerActive = true;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  final controller = CountDownController();

  bool isInit = true;
  late String phone;
  late String verificationCode;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Map<String, dynamic> arg =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      phone = arg['phone'];
      verificationCode = arg['verificationCode'];
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void checkVerification() {
    print('here');
    formKey.currentState!.validate();
    if (currentText != verificationCode) {
      setState(
        () {
          hasError = true;
        },
      );
    } else {
      setState(
        () {
          hasError = false;
        },
      );
      Navigator.pushNamed(context, AfterVerificationScreen.routeName);
    }
  }

  Widget widgetVerificationCode() {
    return Form(
      key: formKey,
      child: PinCodeTextField(
        appContext: context,
        length: 6,
        obscureText: true,
        obscuringCharacter: '*',
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 40,
          fieldWidth: 40,
          activeFillColor: Colors.white,
          selectedFillColor: Colors.white,
          activeColor: Theme.of(context).primaryColor,
          selectedColor: Theme.of(context).primaryColor,
          inactiveFillColor: Colors.white,
          inactiveColor: Theme.of(context).primaryColor,
          errorBorderColor: Colors.red,
        ),
        cursorColor: Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        onChanged: (value) {
          setState(() {
            currentText = value;
            hasError = false;
            isButtonEnabled = currentText.length == 6 ? true : false;
          });
        },
      ),
    );
  }

  Widget widgetErrorCode() {
    return hasError
        ? Container(
            decoration: BoxDecoration(
                color: Colors.pink, borderRadius: BorderRadius.circular(50)),
            padding: const EdgeInsets.all(5),
            child: const Text(
              "קוד שגוי",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          )
        : Container();
  }

  Widget widgetButtonContinue() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
      child: ButtonTheme(
        height: 50,
        child: TextButton(
            onPressed: isTimerActive && isButtonEnabled
                ? () => checkVerification()
                : null,
            child: Text(
              "המשך",
              style: TextStyle(
                  color: isTimerActive && isButtonEnabled
                      ? Colors.white
                      : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )),
      ),
      width: 250,
      decoration: BoxDecoration(
          color: isTimerActive && isButtonEnabled
              ? Theme.of(context).primaryColor
              : Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(color: Colors.grey, offset: Offset(1, -2), blurRadius: 5),
            BoxShadow(color: Colors.grey, offset: Offset(-1, 2), blurRadius: 5)
          ]),
    );
  }

  Widget widgetTextSendEgain() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            verificationCode = sendVerificationCode(phone);
            controller.restart(initialPosition: 0, duration: 30);
            setState(() {
              isTimerActive = true;
            });
          },
          child: Text(
            "שלח לי שוב",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        const Text(
          "?לא קבלתי ",
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Widget widgetTimer() {
    return CountDownProgressIndicator(
      strokeWidth: 5,
      controller: controller,
      valueColor: Theme.of(context).primaryColor,
      backgroundColor: Colors.grey.shade100,
      initialPosition: 0,
      duration: 30,
      timeFormatter: (seconds) {
        return Duration(seconds: seconds)
            .toString()
            .split('.')[0]
            .padLeft(8, '0');
      },
      text: '',
      onComplete: () {
        setState(() {
          isTimerActive = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            const TextCenter(
              text: 'קוד אימות',
              margin: 30,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            const TextCenter(
              text:
                  'נא להזין את הקוד שנשלח אליך במסרון או בהודעה קולית לטלפון הנייד שלך',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            widgetVerificationCode(),
            widgetErrorCode(),
            widgetButtonContinue(),
            widgetTextSendEgain(),
            widgetTimer(),
          ],
        ),
      ),
    );
  }
}
