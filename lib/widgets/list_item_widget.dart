import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/models/post_model.dart';
import 'package:mad_combined_tasks/pages/api_crud/update_record_screen.dart';
import 'package:mad_combined_tasks/services/api_service.dart';
import 'package:mad_combined_tasks/services/utils.dart';

class ListItem extends StatelessWidget {
  final Post post;
  final VoidCallback callFutureService;

  const ListItem({
    Key? key,
    required this.post,
    required this.callFutureService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("${post.id}. ${post.title}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.0)),
                ),
                subtitle: Text(post.body),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateRecord(
                                    id: post.id.toString(),
                                    title: post.title,
                                    body: post.body,
                                  )));
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      Future<String> deleteResponse =
                          deletePost(post.id.toString());
                      String response = await deleteResponse;
                      Utils().showSnackBar(context, Colors.black, response);
                      callFutureService();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
