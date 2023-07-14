import 'package:e_commerce/core/model/login_model.dart';
import 'package:e_commerce/core/network/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared_preference/shared_preference.dart';
import 'auth_states.dart';
class AuthCubit extends Cubit<AuthState>
{
  AuthCubit() : super(InitAuthState());

  static AuthCubit get(context) => BlocProvider.of(context);

  LoginModel? modelLogin;
  logIn({
    required String email,
    required String password,
})
  {
    emit(InitLoginState());
    DioHelper4Shop.postData4Login(
        url: 'login',
        data : {
          'email': email,
          'password': password,
        })
        .then((value){
          modelLogin = LoginModel.fromJson(value.data);
          print('/2////////////////////////////dsc');
          print(modelLogin!.data.email);
          CacheHelper.putData(key: 'token', value: modelLogin!.data.token);
          emit(SuccessLoginState());
    })
        .catchError((error)
    {
      print(error.toString());
      emit(ErrorLoginState());
    });
  }



  register({
    required String email,
    required String password,
    required String phone,
    required String userName,
  })
  {
    DioHelper4Shop.postData4Login(
        url: 'register',
        data : {
          'name' : userName,
          'phone' : phone,
          'email': email,
          'password': password,
        })
        .then((value){
      print(value.data['token']);
    })
        .catchError((error)
    {
      print(error.toString());
    });
  }

}