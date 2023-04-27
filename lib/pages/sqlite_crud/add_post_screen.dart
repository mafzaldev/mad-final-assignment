import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/services/database_helper.dart';
import 'package:mad_combined_tasks/widgets/custom_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController postTextController = TextEditingController();
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
              onPressed: () async {
                if (postTextController.text.isNotEmpty) {
                  await DatabaseHelper.instance.insertPost({
                    DatabaseHelper.colPost: postTextController.text,
                  });
                  postTextController.clear();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
