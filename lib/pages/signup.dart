import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khao/pages/Reuseable.dart';
import 'package:flutter/material.dart';
import 'package:khao/pages/Reuseable.dart';
import 'package:khao/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:romiltp/SignInPage.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:romiltp/firebase_options.dart';
import 'package:khao/global/common/toast.dart';
// import 'package:sign_in_button/sign_in_button.dart';


class SignUpState {
  static bool isSignedUp = false;
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  
  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }
  bool isSigningUp = false;
  String? userName;
  bool isPasswordVisible = false;

  // Sign In With Google
    Future<void> SignInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print("Google sign-in canceled");
        return;
      }
      final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      if (googleAuth == null) {
        print("Google authentication details not available");
        return;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Sign in with the credential
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      // Print user information
      print("User signed in: ${userCredential.user?.displayName}");
      SignUpState.isSignedUp = true;
      Navigator.pushReplacementNamed(context,'/');
      // Update UI with user information
      setState(() {
        userName = userCredential.user?.displayName;
      });
      // Print the username again to check
      print("Updated userName: $userName");
    } catch (e, stackTrace) {
      print("Error during Google sign-in: $e");
      print("StackTrace: $stackTrace");
    }
  }













FirebaseAuth _auth = FirebaseAuth.instance;

//Sign Up Function Which will call SignUpWithEmailAndPassword Function For Firebase Authentication
Future<void> SignUp() async {
  try {
    // Retrieve text from text fields
    String email = _emailTextController.text;
    String password = _passwordTextController.text;
    setState(() {
      isSigningUp = true;
    });
    // Call your signUpWithEmailAndPassword function with the extracted data
    await SignUpWithEmailAndPassword(email, password);
    setState(() {
      isSigningUp = false;
    });
    // Navigator.pushReplacementNamed(context, '/');
  } catch (e, stackTrace) {
    // Handle errors if needed
    print("Error during sign-up: $e");
    print("StackTrace: $stackTrace");
  }
}

//Sign Up With Email And Password Function For Creating New User
Future<User?> SignUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      SignUpState.isSignedUp = true;
      Navigator.pushReplacementNamed(context, '/');
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
       extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 38, 50, 56)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:Color.fromARGB(255, 38, 50, 56)),
        ),
        leading: 
        IconButton(
            icon: Icon(Icons.arrow_back_rounded,size: 36,),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
        )
      ),
      body: Container(     
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white70,

          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
            child: Column(
              children: <Widget>[
                logowidget("assets/sign_up.png"),
                const SizedBox(
                  height: 5,
                ),
                // reusableTextField("Enter UserName", Icons.person_outline, false,
                //     _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email ID", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () async {
                await SignUp();
                setState(() {
                  isSigningUp = false;
                });
              } ),
              firebaseUIButton(context, 'Sign Up With Google', () async {
                await SignInWithGoogle();
              },Icon(FontAwesomeIcons.google, color:Colors.white),),
              ],
            ),
          ))),
    );
  }
}
