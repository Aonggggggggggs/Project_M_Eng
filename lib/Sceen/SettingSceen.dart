import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_eng/Sceen/HomeSceen.dart';
import 'package:flutter_application_eng/widget/TextBox.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'SigninSceen.dart';


class SettingSceen extends StatefulWidget {
  const SettingSceen({super.key});

  @override
  State<SettingSceen> createState() => _SettingSceenState();
}
class _SettingSceenState extends State<SettingSceen> {
  final currrenUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection('Users');
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(context: context, builder:(context)=> AlertDialog(
      backgroundColor: Colors.grey,
      title: Text("แก้ไข$field",
      style: TextStyle(color: Colors.white),),
      content: TextField(autocorrect: true,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'กรอกข้อมูลใหม่$field',
        hintStyle: TextStyle(),

      ),
      onChanged: (value){
        newValue = value;
      },
      ),
      actions: [
        TextButton(onPressed: ()=> Navigator.pop(context), child: Text('ยกเลิก')),
        TextButton(onPressed: ()=> Navigator.pop(context), child: Text('บันทึก'))
      ],
    ));
 if(newValue.trim().length > 0){
  await userCollection.doc(currrenUser.email).update({field:newValue});
 }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(23, 107, 135, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 28, 48, 1),
          centerTitle: true,
          title: Text('ข้อมูลผู้ใช้',style: TextStyle(fontSize: 20),),
          actions: <Widget>[
            IconButton(
                onPressed: () async {
                  await GoogleSignIn().signOut();
                  FirebaseAuth.instance.signOut().then((value) {
                    print('ออกจากระบบ');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Signinsceen()));
                  });
                },
                icon: Icon(Icons.exit_to_app))
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20))
        )
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(currrenUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String,dynamic>;

              return ListView(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(currrenUser.email!,
                  textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontSize: 18),),
                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text('รายละเอียด',style: TextStyle(color: Colors.white),),
                  ),
                  SizedBox(height: 10,),
                  TextBox(
                      text:'ชื่อผู้ใช้',
                      sectionName: userData['username'],
                      onPressed: () => editField("username")),
                  const SizedBox(height: 10,), 
                  TextBox(
                      text:'วันเดือนปีเกิด',
                      sectionName: userData['age'],
                      onPressed: () => editField("age")),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error${snapshot.error}"),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
