import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdatePlans extends StatefulWidget {
  final String documentId, title, description;
  const UpdatePlans({this.documentId, this.title, this.description});

  @override
  _UpdatePlansState createState() => _UpdatePlansState();
}

class _UpdatePlansState extends State<UpdatePlans> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      titleController.text = widget.title;
      descController.text = widget.description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(hintText: "Title"),
              onChanged: (val) {
                setState(() {});
              },
            ),
            TextField(
              controller: descController,
              maxLines: 5,
              decoration: InputDecoration(hintText: "Content"),
              onChanged: (val) {
                setState(() {});
              },
            ),
            RaisedButton(
                child: Text('Update Post'),
                onPressed: () {
                  Firestore.instance
                      .collection('plans')
                      .document(widget.documentId)
                      .updateData({
                    'createdAt': Timestamp.now(),
                    'title': titleController.text.trim(),
                    'description': descController.text.trim()
                  }).then(
                    (value) => Navigator.of(context).pop(),
                  );
                })
          ],
        ),
      ),
    );
  }
}
