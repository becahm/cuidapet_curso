import 'package:cuidapet_curso/app/core/dio/custom_dio.dart';
import 'package:cuidapet_curso/app/repository/secure_storage_repository.dart';
import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthInterceptorsWrapper extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    final prefs = await SharedPrefsRepository.instance;
    options.headers['Authorization'] = prefs.acessToken;

    if (DotEnv().env['profile'] == 'dev') {
      print('######## Request Log ########');
      print('data ${options.data}');
      print('url ${options.uri}');
      print('method ${options.method}');
      print('headers ${options.headers}');
    }
  }

  @override
  Future onResponse(Response response) async {
    print('######## Response Log ########');
    print('data ${response.data}');
  }

  @override
  Future onError(DioError err) async {
    print('######## Error Log ########');
    print('error: $err');
    print('data: ${err.response}');
    // verificar se deu erro 403 ou 401  fazer o refresh do token
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      print('#####Token expirado, tentando refresh token ######');

      await _refreshToken();
      final req = err.request;

      print('#####Token atualizado ######');
      return CustomDio.authInstance.request(req.path, options: req);
    }
    return err;
  }

  Future<void> _refreshToken() async {
    final prefs = await SharedPrefsRepository.instance;
    final security = SecureStorageRepository();
    try {
      final accessToken = prefs.acessToken;
      final refreshToken = await security.refreshToken;

      var resultToken = await CustomDio.instance.put('/login/refresh', data: {
        'token': accessToken,
        'refresh_token': refreshToken,
      });
      await prefs.registerAcessToken(resultToken.data['access_token']);
      await security.registerRefreshToken(resultToken.data['refresh_token']);
    } catch (e) {
      print('#####Erro ao tentar refresh token, fazendo logout ######');
      await prefs.logout();
    }
  }
}
