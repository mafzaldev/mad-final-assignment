import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/services/database_helper.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen>
    with AutomaticKeepAliveClientMixin<PostsScreen> {
  @override
  void initState() {
    super.initState();
    queryAllPosts();
  }

  void queryAllPosts() async {
    var tempPosts = await DatabaseHelper.instance.queryPosts();
    setState(() {
      _posts = tempPosts;
    });
  }

  late List<Map<String, dynamic>> _posts = [];
  TextEditingController editPostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: ((
                  context,
                  index,
                ) {
                  var post = _posts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Card(
                      child: ListTile(
                        title: Text(post["post"].toString()),
                        trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialog(post["id"].toString(),
                                        post["post"].toString());
                                  },
                                  leading: const Icon(Icons.edit),
                                  title: const Text("Update"),
                                )),
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () async {
                                    Navigator.pop(context);
                                    await DatabaseHelper.instance
                                        .deletePost(post["id"]);
                                    var tempPosts = await DatabaseHelper
                                        .instance
                                        .queryPosts();
                                    setState(() {
                                      _posts = tempPosts;
                                    });
                                  },
                                  leading: const Icon(Icons.delete),
                                  title: const Text("Delete"),
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }

  Future<void> showMyDialog(String id, String postText) async {
    editPostController.text = postText;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update'),
          content: Container(
            child: TextField(
                controller: editPostController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                )),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () async {
                  await DatabaseHelper.instance.updatePost({
                    DatabaseHelper.colId: id,
                    DatabaseHelper.colPost: editPostController.text
                  });
                  var tempPosts = await DatabaseHelper.instance.queryPosts();
                  setState(() {
                    _posts = tempPosts;
                  });
                  Navigator.pop(context);
                },
                child: const Text('Update'))
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
