import 'package:cuidapet_curso/app/models/user_model.dart';
import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  @observable
  UserModel loggedUser;

  Future<void> loadUser() async {
    final prefs = await SharedPrefsRepository.instance;
    loggedUser = prefs.acessUserData;
  }

  Future<bool> isLogged() async {
    final prefs = await SharedPrefsRepository.instance;
    final acessToken = prefs.acessToken;
    return acessToken != null;
  }
}
