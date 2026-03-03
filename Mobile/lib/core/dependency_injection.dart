import 'package:altcointrader/barrel_file.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    _cubits();
  }

  static void _cubits() {
    sl.registerCubitF(() => AuthenticationCubit());
    sl.registerCubitF(() => ScreenControllerCubit());
    sl.registerCubitF(() => GeneralCubit());
    sl.registerCubitF(() => ThemeCubit());
  }
}

extension InstanceInjectionExtension on GetIt {
  ScreenControllerCubit get screenControllerCubit => sl<ScreenControllerCubit>();

  AuthenticationCubit get authenticationCubit => sl<AuthenticationCubit>();

  ThemeCubit get themeCubit => sl<ThemeCubit>();

  GeneralCubit get generalCubit => sl<GeneralCubit>();

  void lazyRegisterCubit<T extends Object>(T Function() cubit) {
    if (!sl.isRegistered<T>()) sl.registerLazySingleton<T>(() => cubit());
  }

  void registerCubitF<T extends Object>(T Function() cubit) {
    if (!sl.isRegistered<T>()) sl.registerSingleton<T>(cubit());
  }
}
