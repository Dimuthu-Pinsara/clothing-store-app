import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An error occurred";
    }
  }

  Future<String?> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An error occurred";
    }
  }

  Future<String?> _uploadToImgBB(File imageFile) async {
    String imgbbApiKey = dotenv.env['IMG_BB_API_KEY'] ?? '';

    try {
      final url = Uri.parse('https://api.imgbb.com/1/upload');
      final request = http.MultipartRequest('POST', url)
        ..fields['key'] = imgbbApiKey
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonResult = json.decode(responseData);
        return jsonResult['data']['display_url'];
      }
      return null;
    } catch (e) {
      print("ImgBB Upload Error: $e");
      return null;
    }
  }

  Future<String?> updateFullProfile({
    required String name,
    required String email,
    required String address,
    File? profileImage,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return "User not logged in";

      if (profileImage != null) {
        final imageUrl = await _uploadToImgBB(profileImage);

        if (imageUrl != null) {
          await user.updatePhotoURL(imageUrl);
        } else {
          return "Failed to upload image. Please try again.";
        }
      }

      if (name.isNotEmpty && name != user.displayName) {
        await user.updateDisplayName(name);
      }

      if (email.isNotEmpty && email != user.email) {
        await user.verifyBeforeUpdateEmail(email);
      }

      if (address.isNotEmpty) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'shippingAddress': address,
        }, SetOptions(merge: true));
      }

      await user.reload();
      notifyListeners();

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return "Please log out and log back in to change your email.";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }
}
