import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr5/views/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/setting_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String stroka = "";
  int theme = 0;
  late SharedPreferences sharedPreferences;

  @override
  Future<void> initShared() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('stroka') && sharedPreferences.containsKey('theme')) 
    {
      Navigator.pushNamed(context, Screen.routeName, arguments: {
        'stroka1': sharedPreferences.getString('stroka'),
        'theme': sharedPreferences.getInt('theme')
      });
    }
  }

  @override
  void initState() {
    initShared().then((value) {
      stroka = sharedPreferences.getString('stroka') ?? "";
      theme = sharedPreferences.getInt('theme') ?? 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                sharedPreferences.setString('stroka', value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Screen.routeName,
                    arguments: {
                      'stroka1': sharedPreferences.getString('stroka'),
                      'theme': sharedPreferences.getInt('theme')
                    },
                  );
                },
                child: const Text("Передать аргументы")),
            const SizedBox(
              height: 100,
              width: 100,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<SettingCubit>().toogleTheme();
                if(context.read<SettingCubit>().state.theme == ThemeData.light())
                  sharedPreferences.setInt('theme', 1);
                else
                  sharedPreferences.setInt('theme', 0);
              },
              tooltip: 'Switch Theme',
              child:
                  context.read<SettingCubit>().state.theme == ThemeData.light()
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode),
            ),
          ],
        ));
  }
}