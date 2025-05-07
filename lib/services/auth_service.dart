// ignore_for_file: unused_catch_clause, empty_catches, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_cook/screens/HomePage.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");
  final firebaseAuth = FirebaseAuth.instance;

  Future<bool> signUp({
    required BuildContext context,
    required String name,
    required String surname,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        _registerUser(
          name: name,
          surname: surname,
          username: username,
          email: email,
          password: password,
        );
      }
      return true;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              "Bu E-posta daha önceden kullanılmuş!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.red[600],
          duration: Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.only(bottom: 25, left: 10, right: 10),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false;
    }
  }

  Future<bool> _registerUser({
    required String name,
    required String surname,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final String uid = firebaseAuth.currentUser!.uid;
      await userCollection.doc(uid).set({
        "name": name,
        "surname": surname,
        "username": username,
        "email": email,
        "password": password,
      });
      return true;
    } catch (e) {
      print("Kayıt hatası: $e");
      return false;
    }
  }

  Future<void> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        ScaffoldMessenger.of(context).showSnackBar(girisBasariliMesaj());
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(girisBasarisizMesaj());
    }
  }
}

SnackBar girisBasariliMesaj() {
  return SnackBar(
    content: Center(
      child: Text(
        "Giriş Başarılı!",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    backgroundColor: Colors.greenAccent[400],
    duration: Duration(seconds: 3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    margin: EdgeInsets.only(bottom: 25, left: 10, right: 10),
    behavior: SnackBarBehavior.floating,
  );
}

SnackBar girisBasarisizMesaj() {
  return SnackBar(
    content: Center(
      child: Text(
        "Giriş Başarısız",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    backgroundColor: Colors.red[600],
    duration: Duration(seconds: 3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    margin: EdgeInsets.only(bottom: 25, left: 10, right: 10),
    behavior: SnackBarBehavior.floating,
  );
}
