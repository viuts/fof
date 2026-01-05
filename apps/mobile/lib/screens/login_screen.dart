import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import '../widgets/google_sign_in_button.dart';
import '../theme/app_theme.dart';
import '../services/language_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<GoogleSignInAuthenticationEvent>? _authStreamSubscription;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _googleSignIn.initialize();

    // Check if valid session exists
    try {
      final account = await _googleSignIn.attemptLightweightAuthentication();
      if (account != null) {
        _handleGoogleUser(account);
      }
    } catch (e) {
      // Ignore silent errors
    }

    _authStreamSubscription = _googleSignIn.authenticationEvents.listen((
      event,
    ) async {
      print('Auth Event Received: $event');
      if (event is GoogleSignInAuthenticationEventSignIn) {
        final account = event.user;
        _handleGoogleUser(account);
      }
    });
  }

  @override
  void dispose() {
    _authStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> _handleGoogleUser(GoogleSignInAccount googleUser) async {
    // Avoid double handling if already loading (optional, but good practice)
    if (_isLoading && _errorMessage == null) {
      // Might be double trigger from stream + manual call
      // But authenticate() waits, so it's fine.
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: null,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Auth state stream in main.dart handles navigation
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.message;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).failedToSignIn(e.message ?? 'Unknown')),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = S.of(context).unexpectedError(e.toString());
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).errorLabel(e.toString()))),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    // Only used on Mobile (ElevatedButton)
    try {
      final user = await _googleSignIn.authenticate();
      // If authenticate returns user, handle it (Mobile)
      // Note: authenticationEvents might ALSO fire.
      // If so, _handleGoogleUser will be called twice.
      // Firebase handles this gracefully (re-sign in), but UI might flicker.
      // But verify: v7 authenticate() returns Future<GoogleSignInAccount>.
      _handleGoogleUser(user);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).signInFailed(e.toString()))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingXl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or App Name
              const Icon(
                Icons.restaurant_menu,
                size: 80,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: AppTheme.spacingLg),
              Text(
                S.of(context).appTitle,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacingSm),
              Text(
                S.of(context).discoverTaste,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 60),

              // Error Message
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Sign In Button
              _isLoading
                  ? const CircularProgressIndicator()
                  : buildGoogleSignInButton(
                      context,
                      onPressed: _signInWithGoogle,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
