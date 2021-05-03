import 'package:chat_app/widgets/chat/message_buble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  //chats/q7DbcA2DmK4RBMqQKd9k/messages
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.docs;
          //IQOtqzvE10N0Lguxs6TUO9Wfosr2

          print("user=" + FirebaseAuth.instance.currentUser.uid);
          return ListView.builder(
              reverse: true,
              itemCount: documents.length,
              itemBuilder: (context, index) =>
                  FirebaseAuth.instance.currentUser.uid ==
                          documents[index]['userId']
                      ? MessageBuble(
                          documents[index]['text'],
                          documents[index]['username'],
                          true,
                          key: ValueKey(documents[index].id),
                        )
                      : MessageBuble(documents[index]['text'],
                      documents[index]['username'],
                      false,
                          key: ValueKey(documents[index].id)));
        });
  }
}
