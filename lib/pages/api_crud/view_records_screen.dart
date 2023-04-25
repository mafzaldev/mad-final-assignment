import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/models/post_model.dart';
import 'package:mad_combined_tasks/widgets/list_item_widget.dart';
import 'package:mad_combined_tasks/utils/api_service.dart';

class ViewRecords extends StatefulWidget {
  const ViewRecords({super.key});

  @override
  State<ViewRecords> createState() => _ViewRecordsState();
}

class _ViewRecordsState extends State<ViewRecords>
    with AutomaticKeepAliveClientMixin<ViewRecords> {
  late Future<List<Post>> futurePosts;

  void callFutureService() {
    setState(() {
      futurePosts = fetchPosts();
    });
  }

  @override
  void initState() {
    super.initState();
    callFutureService();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        callFutureService();
      },
      child: Column(
        children: [
          const SizedBox(
            height: 50,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Pull down to refresh",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0)),
            ),
          ),
          Expanded(
            child: Center(
              child: FutureBuilder<List<Post>>(
                future: futurePosts,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final posts = snapshot.data!;
                    return buildList(posts);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildList(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListItem(post: post, callFutureService: callFutureService);
      },
    );
  }
}
