import 'package:flutter/material.dart';
import 'package:chattie/utilities//constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User _loggedInUser;
  late String _messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        _loggedInUser = user;
        print(_loggedInUser.email.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  // Future<void> getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  void messagesStream() async {
    await for (var snapshots in _firestore.collection('messages').snapshots()) {
      for (var message in snapshots.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.power_settings_new_rounded),
              onPressed: () {
                messagesStream();
                // _auth.signOut();
                // Navigator.pop(context);
              }),
        ],
        title: const Text('💬 Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!.docs;

                  List<Text> messageWidgets = [];
                  for (var message in messages) {
                    final messageData = message.data() as Map;
                    final messageText = messageData['text'];
                    final messageSender = messageData['sender'];

                    final messageWidget = Text(
                      '$messageText from $messageSender',
                      style: TextStyle(
                        fontSize: 50.0,
                      ),
                    );
                    messageWidgets.add(messageWidget);
                  }

                  return Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      children: messageWidgets,
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        _messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _firestore.collection('messages').add(
                        {'text': _messageText, 'sender': _loggedInUser.email},
                      );
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
