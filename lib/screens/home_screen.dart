import 'package:account/provider/transaction_provider.dart';
import 'package:account/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          if (provider.transactions.isEmpty) {
            return const Center(
              child: Text('ไม่มีรายการ'),
            );
          } else {
            return ListView.builder(
              itemCount: provider.transactions.length,
              itemBuilder: (context, index) {
                var statement = provider.transactions[index];

                Color emotionColor;
                switch (statement.emotionColor) {
                  case 'Happy':
                    emotionColor = Colors.yellow[300]!;
                    break;
                  case 'Sad':
                    emotionColor = Colors.blue[300]!;
                    break;
                  case 'Angry':
                    emotionColor = Colors.red[300]!;
                    break;
                  case 'Excited':
                    emotionColor = Colors.purple[300]!;
                    break;
                  case 'Bored':
                    emotionColor = Colors.grey[300]!;
                    break;
                  default:
                    emotionColor = Colors.white;
                }

                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  color: emotionColor,
                  child: ListTile(
                    title: Text(statement.note),
                    subtitle: Text(
                      DateFormat('dd MMM yyyy hh:mm:ss').format(statement.date),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text('${statement.emotionColor}'),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        provider.deleteTransaction(statement.id);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return EditScreen(statement: statement);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
