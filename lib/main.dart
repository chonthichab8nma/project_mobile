import 'package:account/screens/form_screen.dart';
import 'package:account/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        //theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(
        //  seedColor: const Color.fromARGB(255, 112, 216, 64)),
        //useMaterial3: true,
        //),
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
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MoodLocker'),
          centerTitle: true,
          backgroundColor: Color(0xFF759FB1),
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
            FormScreen(),
            //Center(child: Text('New Tab')),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 223, 205, 250),
          ),
          child: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.local_florist,
                  size: 30,
                  color: const Color.fromARGB(255, 247, 159, 188),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: const Color.fromARGB(255, 247, 159, 188),
                ),
              ),
            ],
            labelColor: Colors.pink,
            unselectedLabelColor: Colors.pink,
            indicator: BoxDecoration(),
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
