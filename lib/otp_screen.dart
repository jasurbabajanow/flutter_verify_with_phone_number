// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.verificationID,
  });
  final String verificationID;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();
  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "We have sent OTP to you phone number. Plz verify",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(0.25),
                filled: true,
                hintText: 'Enter OTP',
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
              onPressed: _signInWithOTP,
              child: const Text(
                "Verify",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _verificationId = '';
  void _signInWithOTP() async {
    final String smsCode = otpController.text.trim();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsCode);
    await _auth.signInWithCredential(credential);
  }
}
