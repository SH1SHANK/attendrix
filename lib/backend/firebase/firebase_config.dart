import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCv7M2wrA3qsMqschLyvvtxkxGKt-u_LG0",
            authDomain: "attendrix-njs4x1.firebaseapp.com",
            projectId: "attendrix-njs4x1",
            storageBucket: "attendrix-njs4x1.firebasestorage.app",
            messagingSenderId: "642972352871",
            appId: "1:642972352871:web:c3dcea4421c5450bd02fc2",
            measurementId: "G-D3Y5YJFPBJ"));
  } else {
    await Firebase.initializeApp();
  }
}
