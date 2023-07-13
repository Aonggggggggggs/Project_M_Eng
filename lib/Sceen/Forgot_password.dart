import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_eng/Sceen/SigninSceen.dart';
import 'package:flutter_application_eng/widget/widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final EmailController = TextEditingController();
  @override
  void dispose(){ 
    EmailController.dispose();
    super.dispose();
  }

  Future resetPass()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: EmailController.text.trim());
      Fluttertoast.showToast(
      msg: "โปรดเช็คอีเมล์ของคุณเราได้ส่งลิ้งก์รีเซ็ตรหัสผ่านไปแล้ว", gravity: ToastGravity.CENTER);

    }on FirebaseException catch(e){
      Fluttertoast.showToast(
      msg: e.code, gravity: ToastGravity.CENTER);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 28, 48, 1),
          centerTitle: true,
          title: Text('ลืมรหัสผ่าน',style: TextStyle(fontSize: 20),),
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Signinsceen()));
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20)),
        ),
        ),
    body: Center(
      child: Column(
        children: [
          SizedBox(height: 200,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('โปรดกรอกอีเมล์ของคุณเพื่อจะให้เราส่งลิ้งก์รีเซ็ตรหัสผ่านให้คุณ',style: TextStyle(fontSize: 18,),textAlign: TextAlign.center,),
          ),
          SizedBox(height: 10,),
          resableTextField("อีเมล์", Icons.email, false,EmailController),
          SizedBox(height: 10,),
          MaterialButton(
            onPressed: () {
             resetPass();
            },
            child: Text("รีเซ็ตรหัสผ่าน",style: TextStyle(color: Colors.white),),
            color:Color.fromRGBO(45, 187, 29, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),
          )
        ],
      ),
    ),
    );

  }
}