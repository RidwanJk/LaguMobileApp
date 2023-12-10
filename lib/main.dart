import 'package:flutter/material.dart';
import 'package:myapp/views/search_view.dart';
import 'views/HomepageView.dart'; // Import your view class
import 'widgets/BotNav.dart';
import 'views/lib_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyViewWithBotNav(), // Use the combined widget
      routes: {
        '/lib_view': (context) => libview(),
        '/search_view': (context) => SearchView(),
      },
    );
  }
}

class MyViewWithBotNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyView(),
      bottomNavigationBar: BotNav(selectedIndex: 0),
    );
  }
}
