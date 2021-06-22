import 'package:bloc_example/modules/authenticate/login/api_provider/login_api_provider.dart';
import 'package:bloc_example/modules/authenticate/login/model/login_model.dart';

class LoginRepository {
  Future<LoginModel> signIn(String user, String pass) async {
    var login = await LoginApiProvider.login(user, pass);
    return login;
  }

  Future<dynamic> signUp(String user, String pass) async {
    var login = await LoginApiProvider.signUp(user, pass);
    if (login != null) {
      return login;
    } else
      return null;
  }
}
