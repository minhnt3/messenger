import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MessengerScreen(),
    );
  }
}

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messenger'),
        backgroundColor: Colors.blue[400],
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          buildConversationTile(
            'Yen Nhi',
            'ok??',
            '9:27 am',
            'meo1.jpeg',
          ),
          buildConversationTile(
            'Thanh Truc',
            'Hi bae!!',
            '9:10 am',
            'meo2.jpeg',
          ),
          buildConversationTile(
            'Thanh Tuyen',
            'Yep',
            '8:07 am',
            'meo3.jpeg',
          ),
          buildConversationTile(
            'Long Phu',
            'You sent a sticker.',
            'Mon',
            'meo1.jpeg',
          ),
          buildConversationTile(
            'Duc Tien',
            'Ok?',
            'Mon',
            'meo1.jpeg',
          ),
          buildConversationTile(
            'Mom',
            '?',
            'Sun',
            'meo3.jpeg.jpg',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Recent',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget buildConversationTile(
      String name, String message, String time, String imageUrl) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(name),
      subtitle: Text(message),
      trailing: Text(time),
      onTap: () {},
    );
  }
}
