import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widget/widget.dart';
import 'HomeSceen.dart';
import 'SigninSceen.dart';


class SignUpSceen extends StatefulWidget {
  final VoidCallback showLoginPage;

  const SignUpSceen({super.key, required this.showLoginPage});

  @override
  State<SignUpSceen> createState() => _SignUpSceenState();
}

class _SignUpSceenState extends State<SignUpSceen> {
  final EmailController = TextEditingController();

  final PasswordController = TextEditingController();
  
  final ConfirmpasswordController = TextEditingController();

  final UserNameController = TextEditingController();

  @override
  void dispose() {
    EmailController.dispose();

    PasswordController.dispose();

    UserNameController.dispose();

    super.dispose();
  }
   Future addUserDeatails(
      String userName, String email,) async {
    await FirebaseFirestore.instance.collection('users').add({
      'user name': userName,
      'email': email,
    });
  }
  bool passwordConfirmed() {
    if (ConfirmpasswordController.text.trim() == 
        PasswordController.text.trim()){
      return true;
    } else {
      return false;
    }
  }
  Future signUp() async{
    if (passwordConfirmed()){
      
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: EmailController.text.trim(), 
        password: PasswordController.text.trim(),
      );

      
      addUserDeatails(
        UserNameController.text.trim(),
        EmailController.text.trim());
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 28, 48, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Signinsceen()));
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        title: const Text(
          "สมัครสมาชิก",
          style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(
                255,
                255,
                255,
                255,
              )),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(23, 107, 135, 1),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      "กรอกข้อมูลเพื่อสมัครสมาชิก",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    resableTextField("ชื่อผู้ใช้", Icons.person_2_outlined,
                        false, UserNameController),
                    const SizedBox(
                      height: 20,
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
                    resableTextField(
                      "ยืนยันรหัสผ่าน", Icons.lock, true, ConfirmpasswordController),
                    signIn_UpButton(context, false, () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        try {
                          await signUp();
                          _formKey.currentState?.reset();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        } on FirebaseAuthException catch (e) {
                          Fluttertoast.showToast(
                              msg: ("โปรดกรอกข้อมูลให้ถูกต้อง"),
                              gravity: ToastGravity.CENTER);
                        }
                      }
                    }),
                  ],
                ))),
      ),
    );
  }
}
