import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/services/api_service.dart';
import 'package:mad_combined_tasks/services/utils.dart';
import 'package:mad_combined_tasks/widgets/custom_app_bar.dart';
import 'package:mad_combined_tasks/widgets/custom_button.dart';
import 'package:mad_combined_tasks/widgets/custom_text_field.dart';

class UpdateRecord extends StatefulWidget {
  const UpdateRecord({
    super.key,
    required this.id,
    required this.title,
    required this.body,
  });

  final String id, title, body;

  @override
  UpdateRecordState createState() {
    // ignore: no_logic_in_create_state
    return UpdateRecordState();
  }
}

class UpdateRecordState extends State<UpdateRecord> {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  bool status = true;

  @override
  void initState() {
    super.initState();
    idController.text = widget.id;
    titleController.text = widget.title;
    bodyController.text = widget.body;
  }

  @override
  void dispose() {
    idController.dispose();
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Update Post",
        actions: [],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: 'ID',
                  controller: idController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: 'Title',
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: 'Body',
                  controller: bodyController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: "Update",
                  width: 200,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Future<String> updateResponse = updatePost(
                        idController.text,
                        titleController.text,
                        bodyController.text,
                      );
                      String response = await updateResponse;
                      Utils().showSnackBar(context, Colors.black, response);
                    }
                    idController.clear();
                    titleController.clear();
                    bodyController.clear();
                    Navigator.pop(context);
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
