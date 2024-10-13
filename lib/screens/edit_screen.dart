import 'package:account/main.dart';
import 'package:account/models/transactions.dart';
import 'package:account/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  final Transactions statement;

  EditScreen({super.key, required this.statement});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  String? selectedEmotionColor;

  final List<Map<String, dynamic>> emotions = [
    {'name': 'Happy', 'color': Colors.yellow},
    {'name': 'Sad', 'color': Colors.blue},
    {'name': 'Angry', 'color': Colors.red},
    {'name': 'Excited', 'color': Colors.purple},
    {'name': 'Bored', 'color': Colors.grey},
  ];

  @override
  void initState() {
    super.initState();
    titleController.text = widget.statement.id;
    noteController.text = widget.statement.note.toString();
    selectedEmotionColor = widget.statement.emotionColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4.0,
                color: const Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'ID',
                      labelStyle:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 255, 190, 190)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 150, 208, 255)),
                      ),
                    ),
                    controller: titleController,
                    validator: (String? str) {
                      if (str!.isEmpty) {
                        return 'กรุณากรอกข้อมูล';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4.0,
                color: const Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'หมายเหตุ',
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    controller: noteController,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'เลือกอารมณ์',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                children: emotions.map((emotion) {
                  return ChoiceChip(
                    label: Text(emotion['name']),
                    selected:
                        selectedEmotionColor == emotion['color'].toString(),
                    onSelected: (selected) {
                      setState(() {
                        selectedEmotionColor =
                            selected ? emotion['color'].toString() : null;
                      });
                    },
                    selectedColor: emotion['color'],
                    backgroundColor: Colors.grey.shade300,
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var statement = Transactions(
                      id: titleController.text,
                      note: noteController.text,
                      emotionColor: selectedEmotionColor ?? 'Unknown',
                      date: DateTime.now(),
                    );

                    var provider = Provider.of<TransactionProvider>(context,
                        listen: false);
                    provider.updateTransaction(statement);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) {
                          return MyHomePage();
                        },
                      ),
                    );
                  }
                },
                child: const Text('แก้ไขข้อมูล'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color.fromARGB(255, 241, 192, 250),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
