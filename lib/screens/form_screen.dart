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
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2024),
        lastDate: DateTime(2024));
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
        appBar: AppBar(
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
                    height: 20,
                  ),
                  Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                          controller: dateController, // Controller สำหรับวันที่
                          decoration: const InputDecoration(
                            labelText: 'กรอกวันที่ (yyyy-mm-dd)',
                            suffixIcon:
                                Icon(Icons.calendar_today), // ไอคอนเลือกวันที่
                          ),
                          readOnly: true,
                          onTap: () => _selectDate(context)),
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
                          'Red', const Color.fromARGB(255, 241, 100, 251)),
                      buildEmotionIcon('Blue', Colors.blue),
                      buildEmotionIcon('Green', Colors.green),
                      buildEmotionIcon('Yellow', Colors.yellow),
                      buildEmotionIcon('Pink', Colors.pink),
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
                      if (formKey.currentState!.validate()) {}
                    },
                    child: const Text('บันทึก'),
                  ),
                ],
              ),

              //children: [
              //TextFormField(
              //decoration: const InputDecoration(
              //labelText: 'ID',
              //),
              //controller: titleController,
              //validator: (String? str) {
              //if (str!.isEmpty) {
              //return 'กรุณากรอกไอดี';
              //}
              //return null;
              //},
              //),
              //TextFormField(
              //decoration: const InputDecoration(
              //labelText: 'จำนวนเงิน',
              //),
              //keyboardType: TextInputType.number,
              //controller: amountController,
              //validator: (String? input) {
              //try {
              //double amount = double.parse(input!);
              //if (amount < 0) {
              //return 'กรุณากรอกข้อมูลมากกว่า 0';
              //}
              //} catch (e) {
              //return 'กรุณากรอกข้อมูลเป็นตัวเลข';
              //}
              //},
              //),
              //TextButton(
              //  child: const Text('บันทึก'),
              //onPressed: () {
              //if (formKey.currentState!.validate()) {
              // create transaction data object
              //var statement = Transactions(
              //  keyID: null,
              //title: titleController.text,
              //amount: double.parse(amountController.text),
              //date: DateTime.now());

              // add transaction data object to provider
              //                       var provider = Provider.of<TransactionProvider>(context,
              //                         listen: false);
//
              //                      provider.addTransaction(statement);
//
              //                      Navigator.push(
              //                        context,
              //                      MaterialPageRoute(
              //                        fullscreenDialog: true,
              //                      builder: (context) {
              //                      return MyHomePage();
              //                  }));
              //      }
              //  })
              // ],
            )));
  }
}
