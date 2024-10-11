import 'package:account/main.dart';
import 'package:account/models/transactions.dart';

import 'package:flutter/material.dart';
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
  final titleController = TextEditingController();
  String? selectedEmotionColor;
  DateTime currentDate = DateTime.now();

  final List<String> emotionColors = ['Red', 'Blue', 'Green', 'Yellow', 'Pink'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('บันทึกอารมณ์'),
        ),
        body: Padding(
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
                            labelText: 'ไอดี (ใช้เพื่อบอกว่าสีอะไรเป็นสีอะไร)',
                          ),
                          controller: idController,
                          validator: (String? str) {
                            if (str!.isEmpty) {
                              return 'กรุณากรอกไอดี';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                )

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
