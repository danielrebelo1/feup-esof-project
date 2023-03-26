import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/create_account.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final double textFieldWidth = MediaQuery.of(context).size.width * 0.08;
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
        backgroundColor: Colors.transparent,
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: textFieldWidth, vertical: 0),
          child: _page(),
        ),
      ),
    );
  }

  Widget _page() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.008, vertical: 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.001,
                child: _icon(),
              ),
              SizedBox(height: 0),
              _inputField("Email", emailController),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _inputField("Password", passwordController, isPassword: true),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _loginBtn(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _forgotPasswordBtn(),
              SizedBox(height: 0),
              _createAccountBtn(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _icon() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Image.asset('assets/logo.png'),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {bool isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.white));

    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }

  Widget _loginBtn() {
    return ElevatedButton(
      onPressed: () {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((value) => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                               MyHomePage(email: emailController.text, password: passwordController.text,)))
                });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromRGBO(6, 10, 43, 1),
        shape: const StadiumBorder(),
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
      ),
      child: SizedBox(
          width: double.infinity,
          child: Text(
            "Login ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
          )),
    );
  }


  Widget _forgotPasswordBtn() {
    TextEditingController emailController = TextEditingController();

    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Forgot Password"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Enter your email address to reset your password."),
                      SizedBox(height: 10),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text("Reset Password"),
                      onPressed: () {
                        String email = emailController.text;
                        FirebaseAuth.instance.sendPasswordResetEmail(email: email)
                            .then((value) {
                          // Show a success message to the user
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Password reset email sent to $email."),
                            duration: Duration(seconds: 3),
                          ));
                          Navigator.of(context).pop();
                        })
                            .catchError((error) {
                          // Show an error message to the user
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Failed to send password reset email. Please check your email and try again."),
                            duration: Duration(seconds: 3),
                          ));
                        });
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Text(
            "Forgot your password?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035, color: Colors.white,decoration: TextDecoration.underline),
          ),
        ),
      ),
    );
  }

  Widget _createAccountBtn() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateAccountPage()),
            );
          },
          child: Text(
            "Don't have an account? Create now",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, color: Colors.white),
          ),
        ),
      ),
      );
  }
}
