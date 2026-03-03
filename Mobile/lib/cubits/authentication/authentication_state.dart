part of 'authentication_cubit.dart';

class AuthenticationState extends GlobalVars with EquatableMixin {
  final bool isLoading;

  const AuthenticationState({this.isLoading = false});

  @override
  List<Object?> get props => [isLoading];

  AuthenticationState copyWith({bool? isLoading}) {
    return AuthenticationState(isLoading: isLoading ?? this.isLoading);
  }
}
