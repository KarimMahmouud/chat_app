import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final messageCotriller = TextEditingController();

  sendMessage() async {
    final enteredMessage = messageCotriller.text;
    if (enteredMessage.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    messageCotriller.clear();

    final User userID = FirebaseAuth.instance.currentUser!;

    final userData = await FirebaseFirestore.instance
        .collection('user')
        .doc(userID.uid)
        .get();

    await FirebaseFirestore.instance.collection('Chat').add({
      'text': enteredMessage,
      'created': Timestamp.now(),
      'userid': userID.uid,
      'username': userData.data()!['username'],
      'userimage': userData.data()!['imageUrl'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 1, bottom: 15),
      child: Row(children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              labelText: "send a message ...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
            controller: messageCotriller,
            autocorrect: true,
            enableSuggestions: true,
            textCapitalization: TextCapitalization.sentences,
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.send,
          ),
        ),
      ]),
    );
  }
}
