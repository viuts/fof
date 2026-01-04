import 'package:flutter/material.dart';

import 'google_sign_in_button_mobile.dart' // default to mobile
    if (dart.library.html) 'google_sign_in_button_web.dart';

export 'google_sign_in_button_mobile.dart'
    if (dart.library.html) 'google_sign_in_button_web.dart';
