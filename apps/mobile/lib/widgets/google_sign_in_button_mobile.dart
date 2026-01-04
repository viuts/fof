import 'package:flutter/material.dart';

Widget buildGoogleSignInButton({VoidCallback? onPressed}) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    icon: Image.network(
      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/150px-Google_%22G%22_logo.svg.png',
      height: 24,
    ),
    label: const Text('Sign in with Google'),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 3,
    ),
  );
}
