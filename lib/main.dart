import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/provider/app_services.dart';
import 'package:tech_task/services/api_client.dart';

import 'screens/ingredent_selection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppServices(apiClient: ApiClient(baseUrl: "https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev")),
        ),
      ],
      child: MaterialApp(
        title: 'Lunch Recipes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: IngredientSelection(),
      ),
    );
  }
}