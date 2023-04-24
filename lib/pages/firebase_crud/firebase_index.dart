import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/pages/firebase_crud/add_post_screen.dart';
import 'package:mad_combined_tasks/pages/firebase_crud/posts_screen.dart';
import 'package:mad_combined_tasks/widgets/custom_app_bar.dart';

class FirebaseIndex extends StatefulWidget {
  const FirebaseIndex({super.key});

  @override
  State<FirebaseIndex> createState() => _FirebaseIndexState();
}

class _FirebaseIndexState extends State<FirebaseIndex> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: CustomAppBar(
            title: "Firebase Realtime Database CRUD",
            actions: [],
            height: 150,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.create),
                  text: "Create",
                ),
                Tab(
                  icon: Icon(Icons.list),
                  text: "Read, Update and Delete",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [AddPostScreen(), PostsScreen()],
          )),
    );
  }
}
