// import 'package:api_demo/models/post.dart';
import '../models/post.dart';
import '../models/photo.dart';
import '../models/profile.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Post>?> getPosts() async{
    var client = http.Client();

    var urlPost = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var resPost = await client.get(urlPost);
    
    if(resPost.statusCode == 200){
      var json = resPost.body;
      return postFromJson(json);
    }
    return null;
  }
  Future<List<Photo>?> getPhotos() async{
    var client = http.Client();

    var urlPhoto = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    var resPhoto = await client.get(urlPhoto);

    if(resPhoto.statusCode == 200){
      var json = resPhoto.body;
      return photoFromJson(json);
    }
    return null;
  }
  Future<List<Profile>?> getProfiles() async{
    var client = http.Client();

    var urlProfiles = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var resProfiles = await client.get(urlProfiles);

    if(resProfiles.statusCode == 200){
      var json = resProfiles.body;
      return profileFromJson(json);
    }
    return null;
  }
}