import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final googleKey = await account!.authentication;
      //print(account);
      //print('========= Id Token =========');
      //print(googleKey.idToken);
      final signInWithGoogleEndpoint = Uri(
          scheme: 'https',
          host: 'app-google-signin.herokuapp.com',
          path: '/google');
      final session = await http
          .post(signInWithGoogleEndpoint, body: {'token': googleKey.idToken});
      print('=======backend========');
      print(session.body);
      return account;
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future signOut() async {
    await _googleSignIn.signOut();
  }
}
