import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

//*Firebase üzerinden anonymous giriş yapmamızı sağlayan fonksiyon.
  Future<User?> signInAnonymously() async {
    final userCredentials = await _firebaseAuth.signInAnonymously();
    //print(userCredentials.user?.uid);
    return userCredentials.user;
  }

//*Firebase authentication'dan çıkış metodu.
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

//*Firebase kullanıcı online mı değil mi kontrol eden stream.
  Stream<User?> authStatus() {
    return _firebaseAuth.authStateChanges();
  }
}
