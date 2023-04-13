import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final String password;

  const ProfilePage({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
      ),
      body: ImageWidget(email: email, password: password),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String email;
  final String password;

  const ImageWidget({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            'assets/logo.png',
            width: 100.0,
            height: 100.0,
          ),
        ),
         Positioned(
            top: MediaQuery.of(context).size.height * 0.03,
            left: 0,
            right: 0,
            child: SizedBox(
              child: Center(
                child: Text(
                  'Profile',
                  style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.height * 0.05),
                ),
              ),
            )),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.1,
          left: 0,
          right: 0,
          child: Image.asset(
            "assets/profile-icon.png",
            width: MediaQuery.of(context).size.width * 0.03,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
        ),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
              child:  Text(
                "Your e-email associated with this account:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, top: MediaQuery.of(context).size.height * 0.02),
              child: Text(
                email,
                style:  TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                minimumSize: Size(MediaQuery.of(context).size.width * 0.04, MediaQuery.of(context).size.height * 0.06), // text color
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      )
                    });
              }, // Add space between email and logout button
              child: Text(
                'Logout',
                style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.03, color: Colors.blueGrey),
              ),
            ),
          ],
        ))
      ],
    );
  }
}
