import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen>
    with AutomaticKeepAliveClientMixin<PostsScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.ref("posts");
  TextEditingController filterPostController = TextEditingController();
  TextEditingController editPostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
                controller: filterPostController,
                onChanged: ((value) {
                  setState(() {});
                }),
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                )),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FirebaseAnimatedList(
                query: databaseRef,
                itemBuilder: ((context, snapshot, animation, index) {
                  final postText = snapshot.child("postText").value.toString();

                  if (filterPostController.text.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Card(
                        child: ListTile(
                          title:
                              Text(snapshot.child("postText").value.toString()),
                          trailing: PopupMenuButton(
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      showMyDialog(
                                          snapshot.child("id").value.toString(),
                                          postText);
                                    },
                                    leading: const Icon(Icons.edit),
                                    title: const Text("Update"),
                                  )),
                              PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      databaseRef
                                          .child(snapshot
                                              .child("id")
                                              .value
                                              .toString())
                                          .remove();
                                    },
                                    leading: const Icon(Icons.delete),
                                    title: const Text("Delete"),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (postText
                      .toLowerCase()
                      .contains(filterPostController.text.toLowerCase())) {
                    return ListTile(
                      title: Text(snapshot.child("postText").value.toString()),
                    );
                  } else {
                    return Container();
                  }
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
                onPressed: () {
                  databaseRef.child(id).update({
                    "postText": editPostController.text,
                  }).then((value) {
                    log("Post Updated");
                  }).onError((error, stackTrace) {
                    log(error.toString());
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
