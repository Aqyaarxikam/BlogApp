import 'package:blogapp/components/rounded_button.dart';
import 'package:blogapp/components/option_btns.dart';
import 'package:blogapp/screens/login.dart';
import 'package:blogapp/screens/signin.dart';
import 'package:flutter/material.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({Key? key}) : super(key: key);

  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/opbg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 SizedBox(
                  height: 90,
                ),
                Image(
                  image: AssetImage('assets/blog.png'),
                  height: 150,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Welcome!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                OptionButton(
                  title: 'Login',
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                OptionButton(
                  title: 'Register',
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                ),
                SizedBox(
                  height: 140,
                ),
                Text(
                  "Developed by SoCMA group",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}