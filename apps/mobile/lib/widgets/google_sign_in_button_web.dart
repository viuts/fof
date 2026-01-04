import 'package:flutter/material.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart' as web;

import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

Widget buildGoogleSignInButton({VoidCallback? onPressed}) {
  // On Web, the button handles the click and sign-in flow internally.
  // We don't use the parsed onPressed callback.
  // We need to access the renderButton from the web plugin instance.

  // This cast is safe on web because google_sign_in_web registers itself as the instance.
  final plugin = GoogleSignInPlatform.instance as web.GoogleSignInPlugin;

  return plugin.renderButton();
}
