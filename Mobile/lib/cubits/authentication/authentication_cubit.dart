import 'package:altcointrader/barrel_file.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<MasterState<AuthenticationState>> {
  AuthenticationCubit() : super(const Initial(AuthenticationState()));

  void reset() {
    emit(const Initial(AuthenticationState()));
  }

  void logout() {
    sl.authenticationCubit.reset();
    sl.generalCubit.reset();
    sl.screenControllerCubit.reset();
    sl.themeCubit.reset();
  }
}
