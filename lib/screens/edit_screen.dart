import 'package:account/main.dart';
import 'package:account/models/transactions.dart';
import 'package:account/provider/transaction_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  Transactions statement;

  EditScreen({super.key, required this.statement});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final noteController = TextEditingController();
  String? selectedEmotionColor;

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.statement.id;
    noteController.text = widget.statement.note.toString();
    selectedEmotionColor = widget.statement.emotionColor;
    return Scaffold(
        appBar: AppBar(
          title: const Text('แบบฟอร์มแก้ไขข้อมูล'),
        ),
        body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ชื่อรายการ',
                  ),
                  autofocus: false,
                  controller: titleController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Note',
                  ),
                  //keyboardType: TextInputType.number,
                  controller: noteController,
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
                ),
                TextButton(
                    child: const Text('แก้ไขข้อมูล'),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // create transaction data object
                        var statement = Transactions(
                            id: widget.statement.id,
                            note: titleController.text,
                            emotionColor: selectedEmotionColor ?? 'Unknown',
                            date: DateTime.now());

                        // add transaction data object to provider
                        var provider = Provider.of<TransactionProvider>(context,
                            listen: false);

                        provider.updateTransaction(statement);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) {
                                  return MyHomePage();
                                }));
                      }
                    })
              ],
            )));
  }
}
