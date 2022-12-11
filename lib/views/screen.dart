import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/setting_cubit.dart';

class Screen extends StatelessWidget {
  const Screen({super.key});
  
  static const routeName = '/screen2';
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    if(arguments['theme'].toString()== '0' && context.read<SettingCubit>().state.theme == ThemeData.light())
    {
        context.read<SettingCubit>().toogleTheme();
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Следующая страница")),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(arguments['stroka1'].toString()),
          ],
        ),
      ),
    );
  }
}