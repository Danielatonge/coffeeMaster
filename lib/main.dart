import 'package:flutter/material.dart';
import 'package:my_app/pages/offerspage.dart';

import 'datamanager.dart';
import 'pages/menupage.dart';
import 'pages/orderspage.dart';

void main() {
  runApp(const MyApp());
}

class Future extends StatefulWidget {
  const Future({Key? key}) : super(key: key);

  @override
  State<Future> createState() => _FutureState();
}

class _FutureState extends State<Future> {
  var name = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Hello World $name", style: const TextStyle(fontSize: 30)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
        ),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedTab = 0;
  var dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    late Widget currentWidgetPage;

    switch (selectedTab) {
      case 0:
        currentWidgetPage = MenuPage(
          dataManager: dataManager,
        );
        break;
      case 1:
        currentWidgetPage = const OffersPage();
        break;
      case 2:
        currentWidgetPage = OrdersPage(
          dataManager: dataManager,
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Image.asset("images/logo.png"),
      ),
      body: currentWidgetPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        onTap: (newIndex) {
          setState(() {
            selectedTab = newIndex;
          });
        },
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.yellow.shade400,
        unselectedItemColor: Colors.brown.shade100,
        items: const [
          BottomNavigationBarItem(label: "Menu", icon: Icon(Icons.coffee)),
          BottomNavigationBarItem(
              label: "Offers", icon: Icon(Icons.local_offer)),
          BottomNavigationBarItem(
              label: "Order", icon: Icon(Icons.shopping_cart)),
        ],
      ),
    );
  }
}
