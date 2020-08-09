import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:we_care/models/myplans_model.dart';
import 'package:we_care/myplans/update_post.dart';
import 'package:we_care/pages/addPlans.dart';

class MyPlans extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Plans'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddPlans(),
                  ),
                );
              }),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('plans')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data.documents.isEmpty) {
              return Center(
                child: Text(
                  'No plans added yet !!!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
            } else {
              List<String> docIdList =
                  snapshot.data.documents.map((doc) => doc.documentID).toList();
              List<MyPlansModel> _myplans = snapshot.data.documents
                  .map((e) => MyPlansModel.fromDocuments(e))
                  .toList();
              return ListView.builder(
                  itemCount: _myplans.length,
                  itemBuilder: (_, i) {
                    return Container(
                      height: 80,
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(
                            _myplans[i].title.toString(),
                          ),
                          subtitle: Text(
                            _myplans[i].description.toString(),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return UpdatePlans(
                                            title: _myplans[i].title,
                                            description:
                                                _myplans[i].description,
                                            documentId: docIdList[i],
                                          );
                                        });
                                  }),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    Firestore.instance
                                        .collection('plans')
                                        .document(docIdList[i])
                                        .delete();
                                  }),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
