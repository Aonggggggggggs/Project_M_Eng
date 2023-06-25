import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'SigninSceen.dart';


class SettingSceen extends StatefulWidget {
  const SettingSceen({super.key});

  @override
  State<SettingSceen> createState() => _SettingSceenState();
}
final user = FirebaseAuth.instance.currentUser!;

class _SettingSceenState extends State<SettingSceen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.email!),
            const SizedBox(height: 20,),
            ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                print('ออกจากระบบ');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Signinsceen()));
              });
            },
            child: Text('logout'),
            )],
        ),
      
      )
    );
  }
}