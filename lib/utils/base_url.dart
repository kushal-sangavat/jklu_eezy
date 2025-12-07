import 'dart:io' show Platform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String getBaseUrl() {
  // If you explicitly set a PHYSICAL_BACKEND_URL in .env, prefer it (for real devices)
  // final physical = dotenv.env['PHYSICAL_BACKEND_URL'];
  // if (physical != null && physical.isNotEmpty) return physical;
  //
  // if (Platform.isAndroid) {
  //   // Android emulator -> 10.0.2.2, or allow override via ANDROID_BACKEND_URL
  //   return dotenv.env['ANDROID_BACKEND_URL'] ?? dotenv.env['BACKEND_URL'] ?? 'http://10.0.2.2:3000';
  // }
  //
  // if (Platform.isIOS) {
  //   // iOS simulator can use localhost; allow override via IOS_BACKEND_URL
  //   return dotenv.env['IOS_BACKEND_URL'] ?? dotenv.env['BACKEND_URL'] ?? 'http://localhost:3000';
  // }
  //
  // // Fallback for other platforms (desktop, web, etc.)
  return dotenv.env['BACKEND_URL'] ?? 'http://localhost:3000';
}
