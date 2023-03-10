import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(6, 10, 43, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(6, 10, 43, 1),
      ),
      body: ImageWidget(),
    );
  }
}

class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Positioned(bottom: 0, left: 80, child: Image.asset(
        'assets/logo.png',
        width: 240.0, height: 240.0,
      ),),
        Positioned(top: 10,left: 0 , right: 0,
            child: Container( height: 50,
              child: Center(child: Text('PROFILE',style: TextStyle(color: Colors.white,fontSize: 50),),),
            ))
      ],
    );
  }
}