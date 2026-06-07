import 'package:flutter/material.dart';
// import 'package:flutter_application_6/models/post.dart';
// import 'package:flutter_application_6/models/photo.dart';
import 'package:flutter_application_6/models/profile.dart';
import 'package:flutter_application_6/services/remote_service.dart';
// import 'dart:ui';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Profile>? profiles;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    // fetch data from API
    getData();
  }

  void getData() async {
    profiles = await RemoteService().getProfiles();
    if (profiles != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoaded,
      replacement: const Center(child: CircularProgressIndicator()),
      child: ListView.builder(
        itemCount: profiles?.length,
        itemBuilder: (context, index) {
          final profile = profiles?[index];
          return InkWell(
            onTap: () {
              _showProfilePopup(context, profile);
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        //image: NetworkImage(photos![index].url),
                        image: AssetImage('assets/profile_photo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profiles![index].name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          profiles![index].email,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void _showProfilePopup(BuildContext context, dynamic profile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Profile Details'),

        content: SizedBox(
          height: 500,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.all(16)),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 4.0),
                ),
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile_avatar.png'),
                ),
              ),
              SizedBox(height: 8),
              Text(
                profile.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(profile.username, style: TextStyle(fontSize: 20)),
              SizedBox(height: 8),
              Text(profile.email, style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text(profile.phone, style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text(profile.website, style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text(profile.company.name, style: TextStyle(fontSize: 16)),
          
              SizedBox(height: 20),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          20,
                        ), // Rounded corners
                      ),
                    ),
                    child: Text('Back'),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Background color
                      foregroundColor: Colors.white, // Text/icon color
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          20,
                        ), // Rounded corners
                      ),
                    ),
                    child: Text('View profile'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
