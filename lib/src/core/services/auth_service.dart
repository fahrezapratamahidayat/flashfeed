import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      // Check if token is still valid
      try {
        await currentUser.getIdToken(true);
        return true;
      } catch (e) {
        await _auth.signOut();
        await _googleSignIn.signOut();
        return false;
      }
    }
    return false;
  }

  // Email & Password Login
  static Future<User?> loginWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  // Register with Email
  static Future<User?> registerWithEmail(
    String email,
    String password,
    String name,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await userCredential.user?.updateDisplayName(name);

      // Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  // Google Sign In
  static Future<User?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      // Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e);
    } catch (e) {
      throw Exception('Google sign in failed: ${e.toString()}');
    }
  }

  // Logout
  static Future<void> logout() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();

      // Clear login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('is_logged_in');
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }

  // Get current user
  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Check if user has saved credentials (for guest mode)
  static Future<bool> hasCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  // Password reset
  static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  // Handle Firebase errors
  static String _handleFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Email format is invalid';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'email-already-in-use':
        return 'Email is already registered';
      case 'weak-password':
        return 'Password is too weak';
      case 'operation-not-allowed':
        return 'This operation is not allowed';
      default:
        return 'Authentication failed: ${e.message}';
    }
  }
}
