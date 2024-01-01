import 'package:blogapp/components/rounded_button.dart';
import 'package:blogapp/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/dugg.jpg'), // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                SizedBox(height: 120),
                Image(
                  image: AssetImage('assets/regi.png'),
                  height: 130,
                ),
                SizedBox(height: 30),
                Text(
                  'SignUp',textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 42, 69, 164),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                            labelStyle: GoogleFonts.nunito(),
                            prefixIcon: Icon(Icons.email, color: Color(0xff4964c5)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onChanged: (String value) {
                            email = value;
                          },
                          validator: (value) {
                            return value!.isEmpty ? 'enter email' : null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: TextFormField(
                            controller: _password,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              labelText: 'Password',
                              
                              labelStyle: GoogleFonts.nunito(fontSize: 19),
                              prefixIcon: Icon(Icons.lock, color: Color(0xff4964c5)),
                              suffixIcon: Icon(Icons.remove_red_eye, color: Color(0xff4964c5)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onChanged: (String value) {
                              password = value;
                            },
                            validator: (value) {
                              return value!.isEmpty ? 'enter password' : null;
                            },
                          ),
                        ),
                        SizedBox(height: 25),
                        Roundedbutton(
                          title: 'Register',
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                final user = await auth.createUserWithEmailAndPassword(
                                  email: email.toString().trim(),
                                  password: password.toString().trim(),
                                );
                                if (user != null) {
                                  print('SUCCESS');
                                  toastmessages('User successfully created');
                                  setState(() {
                                    showSpinner = false;
                                  });
                                }
                              } catch (e) {
                                print(e.toString());
                                toastmessages(e.toString());
                                setState(() {
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
                              'If you have account? ',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => Login()),
                                  ),
                                );
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 28, 79, 248),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void toastmessages(String message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}