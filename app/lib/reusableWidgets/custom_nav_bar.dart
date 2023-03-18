
import 'package:flutter/material.dart';
import '../pages/search_page.dart';
import '../pages/profile_page.dart';
import '../pages/home_page.dart';

class CustomNavBar extends StatelessWidget {
  final String email;
  final String password;

  const CustomNavBar({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xff302360),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage(email: email, password: password,)),
              );
            },
            child: const Icon(
              Icons.home,
              size: 35,
              color: Colors.white,
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
            child: const Icon(
              Icons.search,
              size: 35,
              color: Colors.white,
            ),
          ),

          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage(email: email, password: password,)),
              );
            },
            child: const Icon(
              Icons.person_outline,
              size: 35,
              color: Colors.white,
            ),
          ),
        ],
      ),
      );
  }
}
