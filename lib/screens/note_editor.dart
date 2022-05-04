import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/style/app_style.dart';

class NoteEditerScreen extends StatefulWidget {
  const NoteEditerScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditerScreen> createState() => _NoteEditerScreenState();
}

class _NoteEditerScreenState extends State<NoteEditerScreen> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);

  String date = DateTime.now().toString();
  TextEditingController _titleController = TextEditingController();
  static TextEditingController mainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Add a new Note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              date,
              style: AppStyle.dateTitle,
            ),
            SizedBox(
              height: 28.0,
            ),
            TextField(
              controller: mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Text',
              ),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async {
          FirebaseFirestore.instance.collection("Notes").add({
            "note_title": _titleController.text,
            "creation_date": date,
            "note_content": mainController.text,
            "color_id": color_id
          }).then((value) {
            print('note_editor ${value.id}');
            Navigator.pop(context);
          }).catchError((error) => print("Failed to add note due to $error"));
        },
        child: Icon(Icons.save),
      ),
      
      
    );
  }
}
