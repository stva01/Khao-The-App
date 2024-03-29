import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }
  bool isSigningUp = false;
  String? userName;
  bool isPasswordVisible = false;

  //Sign In With Google
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
    if (SignUpState.isSignedUp) {
                Navigator.pushReplacementNamed(context, '/onboarding');
              }
              else{
                Navigator.pushReplacementNamed(context, '/home');
              }
    // Update UI with user information
    setState(() {
      userName = userCredential.user?.displayName;
    });
    // Reset authentication-related state
    SignUpState.isSignedUp = false;
    // Print the username again to check
    print("Updated userName: $userName");
  } catch (e, stackTrace) {
    print("Error during Google sign-in: $e");
    print("StackTrace: $stackTrace");
  }
}

FirebaseAuth _auth = FirebaseAuth.instance;




//Sign In Function Which will call SignInWithEmailAndPassword Function For Firebase Authentication
Future<void> SignIn() async {
  try {
    // Retrieve text from text fields
    String email = _emailTextController.text;
    String password = _passwordTextController.text;
    setState(() {
      isSigningUp = true;
    });
    // Call your signUpWithEmailAndPassword function with the extracted data
    await SignInWithEmailAndPassword(email, password);
    setState(() {
      isSigningUp = false;
    });
  } catch (e, stackTrace) {
    // Handle errors if needed
    print("Error during sign-up: $e");
    print("StackTrace: $stackTrace");
  }
}

//Sign In With Email And Password Function For Logging In Existing User
Future<User?> SignInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (SignUpState.isSignedUp) {
                Navigator.pushReplacementNamed(context, '/onboarding');
              }
              else{
                Navigator.pushReplacementNamed(context, '/home');
              }
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    
    }
    return null;
  }



  @override
  void initState() {
    super.initState();
  if(SignUpState.isSignedUp){
     FirebaseAuth.instance.signOut();
  }
  else{
  // Check if user is already signed in
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromARGB(0, 249, 228, 209),
        child: Column(
          children: <Widget>[
            logowidget("assets/logo2.png"),
            reusableTextField("Enter Email ID", Icons.person_outline, false,
                _emailTextController),
            const SizedBox(height: 15),
            reusableTextField("Enter Password", Icons.lock_outline, true,
                _passwordTextController),
            const SizedBox(height: 15),
            firebaseUIButton(context, 'Login', () async {
                await SignIn();
                setState(() {
                  isSigningUp = false;
                });
              } ),
              // Icon(FontAwesomeIcons.google, color: const Color.fromARGB(255, 175, 46, 46),),
            firebaseUIButton(context, 'Sign In With Google', () async {
                await SignInWithGoogle();
              },
              Icon(FontAwesomeIcons.google, color:Colors.white),
              ),
            signUpOption(),
          ],
        ),
      ),  
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.black87)),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/signup');
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
