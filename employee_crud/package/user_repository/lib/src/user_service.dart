import 'package:realm/realm.dart';

class UserService {
  final App atlasApp;

  UserService(this.atlasApp);

  searchUser({required String email}) {}

  Future<User> createUser(String email, String password) async {
    try {
      EmailPasswordAuthProvider authProvider =
        EmailPasswordAuthProvider(atlasApp);
      await authProvider.registerUser(email, password);
      return loginUser(email, password); 
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<User> loginUser(String email, String password) async {
   try {
      Credentials credentials = Credentials.emailPassword(email, password);
      return atlasApp.logIn(credentials);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    return atlasApp.currentUser!.logOut();
  }
}