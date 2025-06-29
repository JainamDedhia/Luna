import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// Import auth logic
import 'services/auth_service.dart';
import 'screens/auth_screen.dart';// Import auth UI
// import 'screens/homeshell.dart';

//mit
import 'package:provider/provider.dart';
import 'locale_provider.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
    return MaterialApp(
      title: 'Medical App - Auth',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      debugShowCheckedModeBanner: false,
      locale: localeProvider.locale,
      supportedLocales: const [
            Locale('en'),
            Locale('hi'),
            Locale('gu'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        home: const AuthScreen(),
      );
    }
    );
  }
}