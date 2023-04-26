import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/pages/sqlite_crud/posts_screen.dart';
import 'package:mad_combined_tasks/pages/sqlite_crud/add_post_screen.dart';
import 'package:mad_combined_tasks/widgets/custom_app_bar.dart';

class SQLiteIndex extends StatefulWidget {
  const SQLiteIndex({super.key});

  @override
  State<SQLiteIndex> createState() => _SQLiteIndexState();
}

class _SQLiteIndexState extends State<SQLiteIndex> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: CustomAppBar(
            title: "SQLite Database CRUD",
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
