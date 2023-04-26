import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/services/api_service.dart';
import 'package:mad_combined_tasks/services/utils.dart';
import 'package:mad_combined_tasks/widgets/custom_button.dart';
import 'package:mad_combined_tasks/widgets/custom_text_field.dart';

class CreateRecord extends StatefulWidget {
  const CreateRecord({super.key});

  @override
  CreateRecordState createState() {
    return CreateRecordState();
  }
}

class CreateRecordState extends State<CreateRecord> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final userIDController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    userIDController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Create Post",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: "Title",
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter post title';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: "Body",
                  controller: bodyController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter post body';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: "User ID",
                  controller: userIDController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter user ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: "Create",
                  width: 200,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Future<String> postResponse = createPost(
                        titleController.text,
                        bodyController.text,
                        userIDController.text,
                      );
                      String response = await postResponse;
                      Utils().showSnackBar(context, Colors.black, response);
                    }
                    titleController.clear();
                    bodyController.clear();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
