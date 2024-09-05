import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const Text(
              'Phone Authentication',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(0.25),
                filled: true,
                hintText: 'Phone number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _verifyPhoneNumber,
              child: const Text("Sign in"),
            ),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatic handling of the SMS code (optional)
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle error
        print('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout
      },
      timeout: const Duration(seconds: 60),
    );
  }
}
