import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_notification_example/colors.dart';
import 'package:push_notification_example/logic/cubit/Post_Ad_Cubit/post_ad_cubit_cubit.dart';
import 'package:push_notification_example/view/screens/add_post.dart';
import 'package:push_notification_example/view/screens/post_details.dart';
import 'package:push_notification_example/view/screens/show_posts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  late PageController pageController;
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdDetailsScreen(
            imageUrl: message.data['imageurl'],
            price: message.data['price'],
            description: message.data['description'],
            title: message.data['title'],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
    pageController = PageController();
    print("=================================Token=========================");
    FirebaseMessaging.instance.getToken().then((token) => print(token));
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        backgroundColor: purple,
        fixedColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box,
              color: Colors.white,
            ),
            label: 'add post',
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
      body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: [
            const ShowAllPosts(),
            BlocProvider<PostAdCubit>(
              create: (context) => PostAdCubit(),
              child: AddPost(),
            ),
          ]),
    );
  }
}
