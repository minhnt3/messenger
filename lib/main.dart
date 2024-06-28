import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // widget MaterialApp có thuộc tính home truyền vào màn hình đầu tiên của app. Mỗi màn hình luôn bắt đầu bởi widget Scaffold
      appBar: AppBar(
        // Scaffold có thuộc tính appBar truyền vào 1 AppBar, AppBar có thuộc tính backgroundColor và title
        backgroundColor: Colors.white,
        title: const Text(
          'Messenger',
          style: TextStyle(fontWeight: FontWeight.bold),
        ), // title cần truyền vào 1 Widget, có thể truyền vào Image hoặc Text
      ),
      body: Container(
        color: Colors.blue,
        child: ListView.builder(
          // Scaffold có thuộc tính body, a truyền vào 1 ListView
          itemCount: 100,
          // ListView có thuộc tính itemCount quyết định listview đó có bao nhiêu item
          itemBuilder: (context, index) {
            // thuộc tính itemBuilder dùng để build UI của 1 item dựa vào index
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MessengerScreen();
                }));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 2.5),
                padding: const EdgeInsets.all(5),
                color: Colors.white,
                // widget Center dùng để canh giữa widget child của nó
                child: Row(
                  children: [
                    Container(child: const SizedBox(width: 10)),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://cdn.pixabay.com/photo/2016/11/18/23/38/child-1837375_1280.png',
                        width: 90,
                        height: 90,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Long Phú' * 100,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Text(
                              'Hello, friend.' * 100,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            )
                          ]),
                    )
                  ],
                ), // widget Text dùng tạo ra Text
              ),
            );
          },
        ),
      ),
    );
  }
}

class MessengerScreen extends StatefulWidget {
  @override
  State<MessengerScreen> createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  int currentIndex = 0;
  var messageList = [
    Message(message: 'Hello', createdAt: DateTime.now(), sentBy: '1'),
    Message(message: 'Hi', createdAt: DateTime.now(), sentBy: '2'),
  ];

  late final chatController = ChatController(
    initialMessageList: messageList,
    scrollController: ScrollController(),
    currentUser: ChatUser(id: '1', name: 'Minh'),
    otherUsers: [ChatUser(id: '2', name: 'Nhi')],
  );

  @override
  Widget build(BuildContext context) {
    print('rebuild UI');
    return Scaffold(
      appBar: AppBar(
        title: Text('Messenger'),
        backgroundColor: Colors.blue[400],
        elevation: 0,
      ),
      body: ChatView(
        chatController: chatController,
        onSendTap: (message, replyMessage, messageType) {
          chatController.addMessage(Message(
              message: message, createdAt: DateTime.now(), sentBy: '1'));
        },
        sendMessageConfig: SendMessageConfiguration(
          textFieldBackgroundColor: Colors.black,
          allowRecordingVoice: false,
          enableCameraImagePicker: false,
          enableGalleryImagePicker: false,
        ),
        chatViewState:
            ChatViewState.hasMessages, // Add this state once data is available.
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.blue),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Colors.black),
            activeIcon: Icon(Icons.chat, color: Colors.blue[400]),
            label: 'Recent',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group, color: Colors.black),
            activeIcon: Icon(Icons.group, color: Colors.blue[400]),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts, color: Colors.black),
            activeIcon: Icon(Icons.contacts, color: Colors.blue[400]),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.black),
            activeIcon: Icon(Icons.settings, color: Colors.blue[400]),
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
      title: Text(
        name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: SizedBox(
        width: 50,
        child: Text(
          time,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onTap: () {},
    );
  }
}
