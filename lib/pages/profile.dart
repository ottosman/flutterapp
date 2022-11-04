import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:face_net_authentication/pages/Kimlik.dart';
import 'package:face_net_authentication/pages/models/user.model.dart';
import 'package:face_net_authentication/pages/widgets/app_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home.dart';

class Profile extends StatelessWidget {
  const Profile(this.user, {Key? key, required this.imagePath})
      : super(key: key);
  final User user;
  final String imagePath;

  final String githubURL =
      "https://github.com/MCarlomagno/FaceRecognitionAuth/tree/master";

  void _launchURL() async => await canLaunch(githubURL)
      ? await launch(githubURL)
      : throw 'Could not launch $githubURL';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(imagePath)),
                      ),
                    ),
                    margin: EdgeInsets.all(20),
                    width: 50,
                    height: 50,
                  ),
                  Text(
                    'Hi ' + user.user + '!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  Text(""),
                  ElevatedButton(
                    onPressed: () async {
                      Uint8List imagebytes = await File(imagePath)
                          .readAsBytes(); //convert to bytes
                      String base64string = base64.encode(imagebytes);
                      log(base64string.toString());
                      await Clipboard.setData(
                          ClipboardData(text: base64string.toString()));

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KimlikPage(),
                          ));
                    },
                    child: Text("Kimliğe Git"),
                  ),
                ],
              ),
              Spacer(),
              AppButton(
                text: "LOG OUT",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                color: Color(0xFFFF6161),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
