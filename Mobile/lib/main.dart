import 'package:altcointrader/core/dependency_injection.dart';
import 'package:flutter/material.dart';

import 'altcointrader_main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  runApp(const AltCoinTraderMain());
}

