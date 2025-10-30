import 'package:flutter/material.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('پروفایل')),
      body: ListView(children: [
        ListTile(title: Text('حریم خصوصی')),
        ListTile(title: Text('تصویر زمینه و تم‌ها')),
        ListTile(title: Text('علاقه‌مندی‌ها')),
        ListTile(title: Text('امتیاز به برنامه')),
        ListTile(title: Text('درباره برنامه')),
        ListTile(title: Text('تنظیمات'), onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen())); }),
      ]),
    );
  }
}
