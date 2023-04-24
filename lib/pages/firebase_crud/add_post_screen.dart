import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mad_combined_tasks/utils/utils.dart';
import 'package:mad_combined_tasks/widgets/custom_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController postTextController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref("posts");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(
                controller: postTextController,
                maxLines: 6,
                decoration: const InputDecoration(
                  hintText: 'Whats on your mind?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                )),
            const SizedBox(height: 20),
            CustomButton(
              text: "Add",
              width: 200,
              onPressed: () {
                String id = DateTime.now().microsecondsSinceEpoch.toString();
                databaseRef
                    .child(id)
                    .set({
                      "id": id,
                      "postText": postTextController.text.toString(),
                    })
                    .then((value) => {
                          Utils().showSnackBar(
                              context, Colors.black, "Post Added"),
                          postTextController.clear(),
                        })
                    .onError((error, stackTrace) => {
                          log(error.toString()),
                          Utils().showSnackBar(
                              context, Colors.red, error.toString()),
                        });
              },
            )
          ],
        ),
      ),
    );
  }
}
