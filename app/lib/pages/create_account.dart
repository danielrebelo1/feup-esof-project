import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF060a2b),
            Color(0xFF0a0e3c),
          ],
        ),
        border: Border.all(
          color: Colors.black,
          width: 10,
        ),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:const Color.fromRGBO(6, 10, 43, 1),
          elevation: 0.0,
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: _page(),
        ),
      ),
    );
  }

  Widget _page() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon(),
              const SizedBox(height: 15),
              _inputField("Email", emailController),
              const SizedBox(height: 20),
              _inputField("Username", usernameController),
              const SizedBox(height: 20),
              _inputField("Password", passwordController, isPassword: true),
              const SizedBox(height: 50),
              _createAccountBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    final double iconSize = MediaQuery.of(context).size.width * 0.40;
    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: Image.asset('assets/logo.png'),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {bool isPassword = false}) {
    final double textFieldWidth = MediaQuery.of(context).size.width * 0.8;
    final double textFieldHeight = MediaQuery.of(context).size.height * 0.08;
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(textFieldHeight * 0.5),
        borderSide: const BorderSide(color: Colors.white));

    return SizedBox(
      width: textFieldWidth,
      height: textFieldHeight,
      child: TextField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          enabledBorder: border,
          focusedBorder: border,
        ),
        obscureText: isPassword,
      ),
    );
  }


  Widget _createAccountBtn() {
    final double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    final double buttonHeight = MediaQuery.of(context).size.height * 0.08;

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () {
          FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
              .then((value) {
            print("Created new account");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(email: emailController.text, password: passwordController.text,)));
          }).onError((error, stackTrace) {
            print("Error ${error.toString()}");
          });
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromRGBO(6, 10, 43, 1),
          shape: const StadiumBorder(),
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: buttonHeight * 0.2),
        ),
        child: const SizedBox(
            width: double.infinity,
            child: Text(
              "Create Account",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            )),
      ),
    );
  }

}
