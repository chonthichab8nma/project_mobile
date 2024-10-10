import 'package:account/screens/form_screen.dart';
import 'package:account/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [
              HomeScreen(),
              FormScreen(),
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                text: "Flower",
                icon: Icon(
                  Icons.local_florist,
                  size: 30,
                  color: Colors.pink,
                ),
              ),
              Tab(
                text: "Add",
                icon: Icon(Icons.add),
              ),
            ],
            labelColor: Colors.pink,
            unselectedLabelColor: Colors.pink,
            indicator: BoxDecoration(
              color: Colors.yellow[300],
              borderRadius: BorderRadius.circular(100),
            ),
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontSize: 14),
          ),
        ));
  }
}
