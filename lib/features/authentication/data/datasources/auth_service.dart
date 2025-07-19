/// 🔐 **AUTHENTICATION SERVICE**
/// 
/// 🎯 **Purpose**: Handle all authentication operations (Google, Email, etc.)
/// 🏗️ **Architecture**: Authentication Feature - Data Layer
/// 🔗 **Dependencies**: Firebase Auth, Google Sign-In
/// 📝 **Usage**: Service class for authentication operations
/// 
/// 📅 **Created**: 2025
/// 👤 **Team**: Luna Development Team

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// 🔑 **Authentication Service**
/// 
/// Handles all authentication operations:
/// - 🔑 Google Sign-In integration
/// - 📧 Email/Password authentication
/// - 🚪 Sign out functionality
/// - 👤 User state management
/// 
/// **Methods**:
/// - `signInWithGoogle()`: Google OAuth authentication
/// - `signOut()`: Sign out from all providers
/// - `currentUser`: Get current authenticated user
/// - `getUserDisplayName()`: Get user's display name
class AuthService {
  // 🔥 **Firebase Auth Instance**
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 👤 **Get Current User**
  /// 
  /// Returns the currently authenticated user or null
  User? get currentUser => _auth.currentUser;

  /// 🔑 **Google Sign-In**
  /// 
  /// Authenticate user using Google OAuth
  /// 
  /// **Returns**: User object if successful, null if cancelled
  /// **Throws**: Exception if authentication fails
  Future<User?> signInWithGoogle() async {
    try {
      // 🔍 **Step 1**: Trigger Google Sign-In flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // User cancelled

      // 🔑 **Step 2**: Get authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 🎫 **Step 3**: Create Firebase credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // ✅ **Step 4**: Sign in to Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      // ❌ **Error Handling**: Re-throw for UI to handle
      rethrow;
    }
  }

  /// 🚪 **Sign Out**
  /// 
  /// Sign out from Firebase and Google
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }

  /// 📝 **Get User Display Name**
  /// 
  /// Returns user's display name or fallback
  /// 
  /// **Priority**:
  /// 1. Firebase display name
  /// 2. Email username (before @)
  /// 3. "User" as fallback
  String getUserDisplayName() {
    final user = currentUser;
    if (user != null) {
      return user.displayName ?? 
             user.email?.split('@')[0] ?? 
             'User';
    }
    return 'User';
  }

  /// 📧 **Email Sign-In** (Future Implementation)
  /// 
  /// Placeholder for email/password authentication
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  /// 📝 **Email Sign-Up** (Future Implementation)
  /// 
  /// Placeholder for email/password registration
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  /// 🔄 **Auth State Stream**
  /// 
  /// Listen to authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// ✅ **Check if User is Authenticated**
  /// 
  /// Quick check for authentication status
  bool get isAuthenticated => currentUser != null;
}