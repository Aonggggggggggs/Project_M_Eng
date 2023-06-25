import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../widget/widget.dart';
import 'HomeSceen.dart';
import 'SignupSceen.dart';


class Signinsceen extends StatefulWidget {
  const Signinsceen({super.key});

  @override
  State<Signinsceen> createState() => _SigninsceenState();
}

class _SigninsceenState extends State<Signinsceen> {
  TextEditingController PasswordController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController facebookController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(23, 107, 135, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              30, MediaQuery.of(context).size.height * 0.2, 20, 0),
          child: Column(
            children: <Widget>[
              logo_widget("assets/images/logo.png"),
              const SizedBox(
                height: 35,
              ),
              resableTextField(
                  "อีเมล์", Icons.person_2_outlined, false, EmailController),
              const SizedBox(
                height: 20,
              ),
              resableTextField(
                  "รหัสผ่าน", Icons.lock, true, PasswordController),
              const SizedBox(
                height: 20,
              ),
              signIn_UpButton(context, true, () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: EmailController.text,
                        password: PasswordController.text)
                    .then((value) {
                  print('เข้าสู่ระบบ');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                }).onError((error, stackTrace) {
                  print("Error,${error.toString()}");
                });
              }),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RoundedLoadingButton(
                    controller: googleController,
                    onPressed: () {
                      signInWithGoogle();
                    },
                    successColor: Colors.red,
                    color: Colors.red,
                    width: MediaQuery.of(context).size.width * 0.8,
                    elevation: 0,
                    borderRadius: 25,
                    child: const Wrap(
                      children: [
                        Icon(
                          FontAwesomeIcons.google,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text("เข้าสู่ระบบผ่าน Gmail",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RoundedLoadingButton(
                    controller: facebookController,
                    onPressed: () {
                      signInWithGoogle();
                    },
                    successColor: Colors.red,
                    width: MediaQuery.of(context).size.width * 0.8,
                    elevation: 0,
                    borderRadius: 25,
                    child: const Wrap(
                      children: [
                        Icon(
                          FontAwesomeIcons.facebook,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text("เข้าสู่ระบบผ่าน Facebook",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("ยังไม่มีบัญชีกดที่นี้",
                      style:
                          TextStyle(color: Color.fromARGB(179, 255, 255, 255))),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpSceen(showLoginPage: () {  },)));
                    },
                    child: const Text(
                      " สมัครสมาชิก",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

signInWithGoogle(){

}