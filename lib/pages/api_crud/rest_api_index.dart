import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/pages/api_crud/create_record_screen.dart';
import 'package:mad_combined_tasks/pages/api_crud/view_records_screen.dart';
import 'package:mad_combined_tasks/widgets/custom_app_bar.dart';

class RESTAPIIndex extends StatefulWidget {
  const RESTAPIIndex({super.key});

  @override
  State<RESTAPIIndex> createState() => _FirebaseIndexState();
}

class _FirebaseIndexState extends State<RESTAPIIndex> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: CustomAppBar(
            title: "REST API CRUD",
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
            children: [CreateRecord(), ViewRecords()],
          )),
    );
  }
}
