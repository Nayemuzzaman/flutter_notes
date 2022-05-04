import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/style/app_style.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {Key? key}) : super(key: key);

  QueryDocumentSnapshot doc;
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  String date = DateTime.now().toString();
  TextEditingController _titleController = TextEditingController();
  static TextEditingController mainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];

    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Text(
              widget.doc["note_title"],
              style: AppStyle.mainTitle,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              widget.doc["creation_date"],
              style: AppStyle.dateTitle,
            ),
            SizedBox(
              height: 28.0,
            ),
            Text(
              widget.doc["note_content"],
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async {
          FirebaseFirestore.instance
              .collection("Notes")
              .doc('value.id')
              .update({
            "note_title": _titleController.text,
            "creation_date": date,
            "note_content": mainController.text,
          }).then((value) {
            print("value.id ");
            Navigator.pop(context);
          }).catchError((error) => print("Failed to add note due to $error"));
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
