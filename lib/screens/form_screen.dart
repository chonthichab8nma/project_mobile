import 'package:account/main.dart';
import 'package:account/models/transactions.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final noteController = TextEditingController();
  final dateController = TextEditingController();

  String? selectedEmotionColor;
  DateTime currentDate = DateTime.now();

  final List<String> emotionColors = ['Red', 'Blue', 'Green', 'Yellow', 'Pink'];

  Future<void> _selectDate(BuildContext context) async {
    print('Date');
    final DateTime? picked = await showDatePicker(
      context: context,
      //initialDate: currentDate,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != currentDate) {
      setState(() {
        currentDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(currentDate);
      });
    }
  }

  Widget buildEmotionIcon(String color, Color iconColor) {
    return GestureDetector(
        onTap: () {
          setState(() {
            selectedEmotionColor = color;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: selectedEmotionColor == color
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : const Color.fromARGB(0, 255, 255, 255),
              width: 2,
            ),
          ),
          child: Icon(
            Icons.local_florist,
            color: iconColor,
            size: 40,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 203, 32, 32),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 255, 210, 234),
                Color.fromARGB(255, 215, 240, 250),
                Color.fromARGB(255, 245, 249, 213)
              ]),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 2.0,
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'ID',
                        ),
                        controller: idController,
                        validator: (String? str) {
                          if (str!.isEmpty) {
                            return 'ID Please';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Card(
                    elevation: 2.0,
                    color: const Color.fromARGB(102, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: dateController,
                        decoration: const InputDecoration(
                          labelText: 'Date',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2030),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              currentDate = pickedDate;
                              dateController.text =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'กรุณากรอกวันที่';
                          }
                          try {
                            DateFormat('yyyy-MM-dd').parseStrict(value);
                          } catch (e) {
                            return 'กรุณากรอกวันที่ในรูปแบบ YYYY-MM-DD';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Your Mood',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 233, 210, 171),
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                          )
                        ]),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildEmotionIcon(
                          'Happy', const Color.fromARGB(255, 236, 206, 69)),
                      buildEmotionIcon(
                          'Sad', const Color.fromARGB(255, 0, 191, 255)),
                      buildEmotionIcon(
                          'Angry', const Color.fromARGB(255, 216, 79, 79)),
                      buildEmotionIcon(
                          'Excited', const Color.fromARGB(255, 187, 67, 187)),
                      buildEmotionIcon(
                          'Bored', const Color.fromARGB(255, 104, 104, 98)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 2.0,
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Note'),
                        controller: noteController,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (selectedEmotionColor == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('กรุณาเลือกอารมณ์')),
                            );
                            return;
                          }
                          var statement = Transactions(
                            id: idController.text,
                            note: noteController.text,
                            emotionColor: selectedEmotionColor ?? 'Unknown',
                            date: currentDate,
                          );
                          var provider = Provider.of<TransactionProvider>(
                              context,
                              listen: false);
                          provider.addTransaction(statement);

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
                      child: Center(
                        child: const Text('Save'),
                      )),
                ],
              ),
            )));
  }
}
