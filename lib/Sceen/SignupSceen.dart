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

  final AgeController = TextEditingController();

  @override
  void dispose() {
    EmailController.dispose();

    PasswordController.dispose();

    UserNameController.dispose();

    AgeController.dispose();

    super.dispose();
  }
    Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        AgeController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }
  addUserDeatails() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    await FirebaseFirestore.instance.collection('Users')
    .doc(currentUser!.email)
    .set({
      "email":EmailController.text,
      "username":UserNameController.text,
      "age":AgeController.text
    });
  }

  bool passwordConfirmed() {
    if (ConfirmpasswordController.text ==
        PasswordController.text) {
      return true;
    } else {
      return false;
    }
  }
  Future signUp() async {
    if (passwordConfirmed()) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: EmailController.text,
        password: PasswordController.text,
      );

      addUserDeatails();
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20))
        ),
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
                    resableTextField(
                        "ชื่อผู้ใช้", Icons.person, false, UserNameController),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: AgeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,horizontal: 15
                        ),
                        hintText: "วันเดือนปีเกิด",hintStyle: const TextStyle(color: Colors.white,),
                        suffix: IconButton(
                          onPressed: ( ) => _selectDateFromPicker(context),
                          icon: Icon(Icons.calendar_today,color: Colors.white,),)
                      ),
                    ),
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
                    resableTextField("ยืนยันรหัสผ่าน", Icons.lock, true,
                        ConfirmpasswordController),
                    const SizedBox(
                      height: 20,
                    ),
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
                              msg: e.code, gravity: ToastGravity.CENTER);
                        }
                      }
                    }),
                  ],
                ))),
      ),
    );
  }
}
