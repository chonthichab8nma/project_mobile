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
                  ? Colors.black
                  : Colors.transparent,
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          //title: const Text('บันทึกอารมณ์'),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
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
                    height: 10,
                  ),
                  Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: dateController,
                        decoration: const InputDecoration(
                          labelText: 'กรอกวันที่ (year-month-day)',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        //onTap: () => _selectDate(context)),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(
                              FocusNode()); // เพื่อป้องกันคีย์บอร์ดจากการเปิดขึ้น
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2030),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              currentDate = pickedDate;
                              dateController.text = DateFormat('yyyy-MM-dd')
                                  .format(pickedDate); // แสดงวันที่ในฟิลด์
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
                    'เลือกอารมณ์ของคุณ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildEmotionIcon(
                          'Happy', const Color.fromARGB(255, 250, 218, 39)),
                      buildEmotionIcon(
                          'Sad', const Color.fromARGB(255, 10, 8, 124)),
                      buildEmotionIcon(
                          'Angry', const Color.fromARGB(255, 255, 35, 35)),
                      buildEmotionIcon(
                          'Excited', const Color.fromARGB(255, 157, 59, 255)),
                      buildEmotionIcon(
                          'Bored', const Color.fromARGB(255, 20, 21, 24)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 2.0,
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
