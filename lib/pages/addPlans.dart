import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPlans extends StatefulWidget {
  @override
  _AddPlansState createState() => _AddPlansState();
}

class _AddPlansState extends State<AddPlans> {
  final formKey = GlobalKey<FormState>();
  // controllers for title and description
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Plans'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Add Plans",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),

                  //for title
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Title",
                    ),
                    onChanged: (val) {
                      setState(() {});
                    },
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  //for description
                  TextFormField(
                    controller: descController,
                    decoration: InputDecoration(
                      hintText: "Description",
                    ),
                    onChanged: (val) {
                      setState(() {});
                    },
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  RaisedButton(
                      child: Text('Add Plans'),
                      onPressed: () {
                        formKey.currentState.save();
                        if (formKey.currentState.validate() == true) {
                          Firestore.instance
                              .collection('plans')
                              .document()
                              .setData({
                            'title': titleController.text,
                            'description': descController.text,
                            'createdAt': Timestamp.now(),
                          }).then((value) => Navigator.pop(context));
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
