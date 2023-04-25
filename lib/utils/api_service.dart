import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'utils.dart';
import 'package:mad_combined_tasks/models/post_model.dart';
import 'package:http/http.dart' as http;

Future<List<Post>> fetchPosts() async {
  final response = await http.get(Uri.parse(ApiConstants.apiUrl));
  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    return body["posts"].map<Post>((post) => Post.fromJson(post)).toList();
  } else {
    log("error");
    throw Exception('Failed to load record');
  }
}

Future<String> createPost(
    String title, String description, String userID) async {
  log(Uri.parse("${ApiConstants.apiUrl}/add").toString());
  var body = jsonEncode({
    "title": title.toString(),
    "body": description.toString(),
    "userId": userID.toString(),
  });
  final response = await http.post(Uri.parse("${ApiConstants.apiUrl}add"),
      body: body, headers: {"Content-Type": "application/json"});
  if (response.statusCode == 200) {
    var responseMessage = jsonDecode(response.body);
    log(responseMessage.toString());
    return "Post created successfully with: \nID: ${responseMessage["id"]}, \nTitle: ${responseMessage["title"]}, \nBody: ${responseMessage["body"]} \nUserID: ${responseMessage["userId"]}";
  } else {
    throw Exception('Failed to send record');
  }
}

Future<String> deletePost(String id) async {
  log(Uri.parse("${ApiConstants.apiUrl}/$id").toString());
  final response = await http.delete(Uri.parse("${ApiConstants.apiUrl}/$id"));

  if (response.statusCode == 200) {
    var responseMessage = jsonDecode(response.body);
    return responseMessage["isDeleted"] == true
        ? "Post deleted successfully with id: ${responseMessage["id"]}"
        : "Post deletion failed";
  } else {
    throw Exception('Failed to delete record');
  }
}

Future<String> updatePost(String id, String postTitle, String postBody) async {
  var body = jsonEncode({
    "title": postTitle.toString(),
    "body": postBody.toString(),
  });
  final response = await http.put(Uri.parse("${ApiConstants.apiUrl}/$id"),
      body: body, headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    var responseMessage = jsonDecode(response.body);
    return "Post updated successfully with: \nID: ${responseMessage["id"]}, \nTitle: ${responseMessage["title"]}, \nBody: ${responseMessage["body"]}";
  } else {
    throw Exception('Failed to update record');
  }
}
