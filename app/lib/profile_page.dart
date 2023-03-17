import 'package:flutter/material.dart';
import 'package:project/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
      ),
      body: const ImageWidget(),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 160,
          child: Image.asset(
            'assets/logo.png',
            width: 100.0,
            height: 100.0,
          ),
        ),
        const Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  'PROFILE',
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
              ),
            )),
        Positioned(
          top: 95,
          left: 0,
          right: 0,
          child: Image.asset(
            "assets/profile-icon.png",
            width: 120.0,
            height: 120.0,
          ),
        ),
        Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const Text(
                    "Your e-email associated with this account:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  child: const Text(
                    "this.is.a.test@gmail.com",
                    style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: const Text(
                    "Your password:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "IdontKnow",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  )
                ),
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // background color
                    onPrimary: Colors.black,
                    minimumSize: Size(150, 50),// text color
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: Text('Logout',style: TextStyle(fontSize: 25, color: Colors.blueGrey),),
                ),
            ],
          )
        )
      ],
    );
  }
}
