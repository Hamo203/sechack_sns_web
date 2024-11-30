import 'package:flutter/material.dart';
import 'package:sechack_sns_web/view/account/user_auth.dart';
import 'package:sechack_sns_web/view/timeline/timeline.dart';

import 'view/account/accountpage.dart';
import 'view/talk/chatroom.dart';
import 'view/timeline/postpage.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int selectedIndex=0;
  String auth=userAuth.currentUser!.uid;
  List<Widget> pagelist =[];
  @override
  void initState() {
    super.initState();

    //Personalページはuseridがログイン者になるように指定する
    auth = userAuth.currentUser!.uid;
    print("auth:"+auth);
    pagelist = [
      Timeline(),
      Postpage(),
      Accountpage(userid: auth),
      Chatroom()
    ];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:pagelist[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedItemColor: Colors.black26,
        unselectedItemColor: Colors.black26, // 未選択アイテムの色
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Timeline',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            label: 'Personal',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Message'),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex=index;
          });
          // Handle button tap
        },
      ),
      
    );
  }
}
