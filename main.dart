import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/language_provider.dart';
//import 'screens/auth_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => LanguageProvider(), child: IranSafarApp()));
}

class IranSafarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context).lang;
    return MaterialApp(
      title: 'ایران سفر',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),home: Scaffold(
  body: Center(
    child: Text('تست پروژه بدون AuthScreen 👋'),
  ),
),

     // home: AuthScreen(),
      // We will pass language via Provider; screens read translations from JSON assets.
    );
  }
}
