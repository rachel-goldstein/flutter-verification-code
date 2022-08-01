library my_prj.functions;

import 'dart:math';

String sendVerificationCode(String phone) {
  var rng = Random();
  var code = rng.nextInt(900000) + 100000;
  return code.toString();
}
