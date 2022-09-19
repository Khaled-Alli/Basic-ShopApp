import 'package:shop_app/models/userdata_model.dart';

abstract class RegistrationState{}
class InitialRegistrationState extends RegistrationState{}
class ChangeVisabilityState extends RegistrationState{}
class UserLoginSuccessState extends RegistrationState{
  final UserDataModel userData;

  UserLoginSuccessState(this.userData);
}
class UserLoginErrorState extends RegistrationState{
  final String error;
  UserLoginErrorState(this.error);

}
class UserLoginLoadingState extends RegistrationState{}

class UserRegisterSuccessState extends RegistrationState{
  final UserDataModel userData;

  UserRegisterSuccessState(this.userData);
}
class UserRegisterErrorState extends RegistrationState{
  final String error;
  UserRegisterErrorState(this.error);

}
class UserRegisterLoadingState extends RegistrationState{}
