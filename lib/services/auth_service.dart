import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";

class AuthService extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> register(
      String username, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      firebaseFirestore.collection("Users").doc(user!.uid).set({
        "uid": user.uid,
        "username": username,
        "email": email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> registerRide(String userUID, String from, String to,
      String contactNumber, String time, String date) async {
    List<String> travelIDList = [userUID, from, Timestamp.now().toString()];
    travelIDList.sort();
    String travelID = travelIDList.join("-");

    await firebaseFirestore.collection("rides").add({
      "from": from,
      "to": to,
      "phone": contactNumber,
      "userUID": userUID,
      "time": time,
      "date": date
    });
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
