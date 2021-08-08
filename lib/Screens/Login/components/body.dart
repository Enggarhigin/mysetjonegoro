import 'package:flutter/material.dart';
import 'package:rsud_setjo/Screens/Login/components/background.dart';
import 'package:rsud_setjo/components/rounded_button.dart';
import 'package:http/http.dart' as http;
import 'package:rsud_setjo/components/rounded_input_field.dart';
import 'package:rsud_setjo/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  Future<List> _login() async {
    final response = await http.post(Uri.parse(
      "http://36.67.10.15:1317/bridging_pendaftaranonline/Login.php",
    ));
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   "LOGIN",
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            Text(
              "#Pastikan Perangkat Anda Terhubung Internet",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),

            RoundedInputField(
              hintText: "Masukkan Nomor RM",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                // print('cek');
                _login();
              },
            ),
            SizedBox(height: size.height * 0.03),
            // AlreadyHaveAnAccountCheck(
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return SignUpScreen();
            //         },
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
