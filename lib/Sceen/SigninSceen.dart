import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../widget/widget.dart';
import 'Forgot_password.dart';
import 'HomeSceen.dart';
import 'SignupSceen.dart';


class Signinsceen extends StatefulWidget {
  const Signinsceen({super.key});

  @override
  State<Signinsceen> createState() => _SigninsceenState();
}

class _SigninsceenState extends State<Signinsceen> {
  final PasswordController = TextEditingController();
  final EmailController = TextEditingController();
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
              30, MediaQuery.of(context).size.height * 0.15, 20, 0),
          child: Column(
            children: <Widget>[
              logo_widget("assets/images/logo.png"),
              const SizedBox(
                height: 35,
              ),
              resableTextField(
                  "อีเมล์", Icons.email, false, EmailController),
              const SizedBox(
                height: 20,
              ),
              resableTextField(
                  "รหัสผ่าน", Icons.lock, true, PasswordController),
              const SizedBox(
                height: 20,
              ),
              signIn_UpButton(context, true, () async{
                try{
                await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: EmailController.text.trim(),
                        password: PasswordController.text.trim());
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                }on FirebaseException catch(e){
                  Fluttertoast.showToast(msg: e.code,
                  gravity: ToastGravity.CENTER);
                }
                      
              }),
              /*signIn_UpButton(context, true, () async{
                await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: EmailController.text.trim(),
                        password: PasswordController.text.trim())
                    .then((value) {
                  print('เข้าสู่ระบบ');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                }).onError((error, stackTrace) {
                  Fluttertoast.showToast(
                    msg: error.toString(), gravity: ToastGravity.CENTER);
                  print("Error,${error.toString()}");


                });
              }),*/
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RoundedLoadingButton(
                    controller: googleController,
                    onPressed: () async{
                    await signInWithGoogle();
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
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
                        Text(
                          "เข้าสู่ระบบผ่าน Gmail",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
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
                    onPressed: () {},
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
                        Text(
                          "เข้าสู่ระบบผ่าน Facebook",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
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
                              builder: (context) => SignUpSceen(
                                    showLoginPage: () {},
                                  )));
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
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("หรือ",
                      style:
                          TextStyle(color: Color.fromARGB(179, 255, 255, 255))),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Forgot(
                                  
                                  )));
                    },
                    child: const Text(
                      "ลืมรหัสผ่าน",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

signInWithGoogle()async{
final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
final GoogleSignInAuthentication gAuth = await gUser!.authentication;
final credential = GoogleAuthProvider.credential(
  accessToken: gAuth.accessToken,
  idToken: gAuth.idToken);
return await FirebaseAuth.instance.signInWithCredential(credential);
}

