import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCwcEh5AbZrj4mwLgygqIdiVqdRmYan_HI",
            authDomain: "attendrix-5ke7lp.firebaseapp.com",
            projectId: "attendrix-5ke7lp",
            storageBucket: "attendrix-5ke7lp.firebasestorage.app",
            messagingSenderId: "69228740786",
            appId: "1:69228740786:web:edc9ad09d9a758d2e1c9ab"));
  } else {
    await Firebase.initializeApp();
  }
}
