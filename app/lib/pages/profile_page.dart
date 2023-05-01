import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/login_page.dart';
import 'package:crypto/crypto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
class ProfilePage extends StatelessWidget {
  final String email;
  final String username;
  final String password;

  const ProfilePage({Key? key, required this.email, required this.username, required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                )
              });
            },
          ),
        ],
      ),
      body: ImageWidget(email: email, username: username, password: password),
    );
  }
}


class ImageWidget extends StatefulWidget {
  final String email;
  final String password;
  final String username;


  const ImageWidget({Key? key, required this.email, required this.username, required this.password})
      : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ImageWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  User? user;
  String? url;
  void initState() {
    super.initState();
    user=FirebaseAuth.instance.currentUser;
    if (user != null) {
      usernameController.text= user?.displayName ?? "";
      emailController.text = user?.email ?? "";
      url="https://0.gravatar.com/avatar/"+md5.convert(utf8.encode(emailController.text)).toString();
    }

  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
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
                  "Hi "+(user?.displayName?? "user"),
                  style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.height * 0.05),
                ),
              ),
            )),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.1,
          left: 0,
          right: 0,
          child:
              GestureDetector(
              onLongPress: () async {
                final uri=Uri.parse("https://gravatar.com/emails/");
             if(await canLaunchUrl(uri)){
              await launchUrl(uri,mode:LaunchMode.externalApplication);
            }

    },
        child:
          Image.network(
            url?? "No image",
            width: MediaQuery.of(context).size.width * 0.03,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
        ),
        ),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            _emailField(emailController.text),
    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            _inputField( usernameController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.white,
                fixedSize: Size(200, 50), // text color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              onPressed: () {
                final lastDisplayName = user?.displayName ?? '';
                final newDisplayName = usernameController.text;
                user?.updateDisplayName(newDisplayName).then((value) {
                  user=FirebaseAuth.instance.currentUser;
                  if (newDisplayName == lastDisplayName) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Nothing updated!'),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ),

                    );
                  } else {
                    setState(() {
                      user=FirebaseAuth.instance.currentUser;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Updated ' + newDisplayName + '!'),
                        duration: Duration(seconds: 3),
                        backgroundColor: Color.fromRGBO(0, 150, 100, 1),
                      ),
                    );
                  }
                });


              }, // Add space between email and logout button
              child: Text(
                'Update Profile',
                style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.03, color: Color.fromRGBO(6, 10, 43, 1)),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),


          ],
        ))
      ],
    );
  }

  Widget _inputField( TextEditingController controller,
      {bool isPassword = false}) {
    final double textFieldWidth = MediaQuery.of(context).size.width * 0.8;
    final double textFieldHeight = MediaQuery.of(context).size.height * 0.08;

    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(textFieldHeight * 0.5),
        borderSide: const BorderSide(color: Colors.white));

    return Container(
      width: textFieldWidth,
      height: textFieldHeight,
      decoration: BoxDecoration(
        color: Colors.white, // change this to your desired background color
        borderRadius: BorderRadius.circular(textFieldHeight * 0.2),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Username:",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(6, 10, 43, 1),
              ),
            ),
          ),

          Expanded(
            child: TextField(
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(6, 10, 43, 1),),
              controller: controller,
              decoration: InputDecoration(
                enabledBorder: border,
                focusedBorder: border,

              ),
              obscureText: isPassword,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: Color.fromRGBO(6, 10, 43, 1),
            ),
          ),
        ],
      ),
    );
  }


  Widget _emailField(String email) {
    final double textFieldWidth = MediaQuery.of(context).size.width * 0.8;
    final double textFieldHeight = MediaQuery.of(context).size.height * 0.08;

    return Container(
      width: textFieldWidth,
      height: textFieldHeight,
      decoration: BoxDecoration(
        color: Colors.white, // change this to your desired background color
        borderRadius: BorderRadius.circular(textFieldHeight * 0.2),
      ),
      child: Row(
        children: [
          Text(
            '  Email: ',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(6, 10, 43, 1),
            ),
          ),
          Text(
            email,
            style: TextStyle(
              fontSize: 17,
              color: Color.fromRGBO(6, 10, 43, 1),
            ),
          ),
        ],
      ),
    );
  }



}
