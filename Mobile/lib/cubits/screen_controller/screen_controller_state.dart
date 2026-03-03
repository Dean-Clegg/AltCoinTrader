part of 'screen_controller_cubit.dart';

enum MainScreens {
  home('Home', Icons.home),
  market('Market', Icons.trending_up),
  wallet('Wallet', LucideIcons.wallet);

  final String displayName;
  final IconData icon;

  const MainScreens(this.displayName, this.icon);
}

extension WebScreenExtension on MainScreens {
  Widget get view {
    switch (this) {
      case MainScreens.home:
        return const HomeScreen();
      case MainScreens.market:
        return const MarketScreen();
      case MainScreens.wallet:
        return const WalletScreen();
    }
  }
}

enum DrawerScreens {
  home('Home', LucideIcons.house),
  history('History', LucideIcons.history),
  easyBuy('Easy Buy', LucideIcons.shoppingBasket),
  easySave('Easy Save', LucideIcons.circlePercent),
  actPay('ACT Pay', LucideIcons.creditCard),
  actBuy('ACT Buy', LucideIcons.shoppingBasket),
  news('News', LucideIcons.newspaper),
  deposit('Deposit', LucideIcons.banknoteArrowUp),
  withdraw('Withdraw', LucideIcons.banknoteArrowDown);

  final String displayName;
  final IconData icon;

  const DrawerScreens(this.displayName, this.icon);
}

class ScreenControllerState extends GlobalVars with EquatableMixin {
  final MainScreens currentScreen;
  final List<MainScreens> availableScreens;

  const ScreenControllerState({this.currentScreen = MainScreens.home, this.availableScreens = MainScreens.values});

  @override
  List<Object?> get props => [currentScreen, availableScreens];

  ScreenControllerState copyWith({MainScreens? currentScreen, List<MainScreens>? availableScreens}) {
    return ScreenControllerState(
      currentScreen: currentScreen ?? this.currentScreen,
      availableScreens: availableScreens ?? this.availableScreens,
    );
  }
}
