import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_provider.dart';
import '../services/lang_utils.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selected = 'fa';
  Map<String, String> langs = {'fa':'فارسی','en':'English','ar':'العربية','ru':'Русский','zh':'中文','hi':'हिन्दी'};

  @override
  void initState(){ super.initState(); selected = Provider.of<LanguageProvider>(context, listen:false).lang; }

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('تنظیمات')),
      body: FutureBuilder(
        future: LangUtils.load(lp.lang),
        builder: (ctx, snap) {
          return ListView(padding: EdgeInsets.all(16), children: [
            Text('انتخاب زبان', style: TextStyle(fontSize:18, fontWeight: FontWeight.bold)),
            ...langs.entries.map((e) => RadioListTile<String>(title: Text(e.value), value: e.key, groupValue: selected, onChanged: (v){ setState(()=>selected=v!); } )).toList(),
            SizedBox(height:12),
            ElevatedButton(onPressed: () async { await lp.setLang(selected); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('زبان ذخیره شد'))); }, child: Text('ذخیره'))
          ]);
        },
      ),
    );
  }
}
