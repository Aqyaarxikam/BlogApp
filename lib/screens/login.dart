import 'package:blogapp/screens/forgotpassword.dart';
import 'package:blogapp/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:blogapp/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:blogapp/screens/signin.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/dugg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.transparent, // Make the container transparent
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(height: 38),
                        Image(
                          image: AssetImage('assets/lo.png'),
                          height: 120,
                          width: 30,
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Login',
                          style: GoogleFonts.nunito(
                            fontSize: 35,
                            fontWeight: FontWeight.w800,
                            color: Color.fromARGB(255, 42, 69, 164),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _email,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: GoogleFonts.nunito(fontSize: 19),
                                    prefixIcon: Icon(Icons.email, color: Color(0xff4964c5)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff4964c5)),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  onChanged: (String value) {
                                    email = value;
                                  },
                                  validator: (value) {
                                    return value!.isEmpty ? 'Enter email' : null;
                                  },
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: _password,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: GoogleFonts.nunito(fontSize: 19),
                              prefixIcon: Icon(Icons.lock, color: Color(0xff4964c5)),
                              suffixIcon: Icon(Icons.remove_red_eye, color: Color(0xff4964c5)),
                                    
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff4964c5)),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  onChanged: (String value) {
                                    password = value;
                                  },
                                  validator: (value) {
                                    return value!.isEmpty ? 'Enter password' : null;
                                  },
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Forgotpassword(),
                                      ),
                                    );
                                  },
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Forgot Password',
                                      style: TextStyle(color: Color.fromARGB(255, 42, 69, 164),fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Roundedbutton(
                                  title: 'Login',
                                  onPress: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        showSpinner = true;
                                      });
                                      try {
                                        final user = await auth.signInWithEmailAndPassword(
                                          email: email.trim(),
                                          password: password.trim(),
                                        );
                                        if (user != null) {
                                          print('SUCCESS');
                                          toastMessages('User successfully logged in');
                                          setState(() {
                                            showSpinner = false;
                                          });
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Home(),
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        print(e.toString());
                                        toastMessages(e.toString());
                                        setState((){
                                          showSpinner = false;
                                        });
                                      }
                                    }
                                  },
                                ),
                                SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'If you have not? ',
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: ((context) => SignIn()),
                                            ));
                                      },
                                      child: Text('Register',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Color.fromARGB(255, 28, 79, 248),
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toastMessages(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xFF84AF9C),
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}