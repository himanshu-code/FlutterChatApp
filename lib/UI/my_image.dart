import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyImage extends StatefulWidget {
  @override
  _MyImageState createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  File imagefilepath;
  var imgurl;
  var furl;
  var authc = FirebaseAuth.instance;
   
  Future clickphoto() async {
    var signInUser = authc.currentUser.email;
    var picker = ImagePicker();
    final image = await picker.getImage(
      source: ImageSource.camera,
        //maxWidth: 400,
        //maxHeight: 400,
    );

    print(imagefilepath);
    print('photo clicked');

    setState(() {
       if (image != null) {
        imagefilepath = File(image.path);
      } else {
        print('No image selected.');
      }
    });

    final fbstorage =
        FirebaseStorage.instance.ref().child("myimagesa$signInUser").child("my.jpg");
    print(fbstorage);

    fbstorage.putFile(imagefilepath);

    imgurl = await fbstorage.getDownloadURL();
    print(imgurl);

    setState(() {
      furl = imgurl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: clickphoto,
      ),
      appBar: AppBar( backgroundColor: Colors.black,
        title: Text('My Profile'),
        actions: <Widget>[
          CircleAvatar(
            backgroundImage:  NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/himanshuchat-e421d.appspot.com/o/quickchat.png?alt=media&token=eb647c63-339b-436e-ad90-0db3e30a905b'),
          )
        ],
      ),
      body: Container( alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child:
              Stack( alignment: Alignment.topCenter,
                children: [Container( //alignment: Alignment.centerLeft,
                  height:150,
                  width:300,
                  margin: EdgeInsets.only(top:155,),
                  //color: Colors.blueAccent,
                  decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.only(topRight: Radius.circular(150),bottomLeft:Radius.circular(50),bottomRight: Radius.circular(50),topLeft: Radius.circular(150)  ) ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[Icon(Icons.mail,color:Colors.black),Text("${authc.currentUser.email}")]),
                ),
                Container( //alignment: Alignment.topCenter,
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(color: Colors.amberAccent,borderRadius:BorderRadius.circular(80),image:DecorationImage(fit:BoxFit.fill ,image: (imagefilepath == null) ? NetworkImage('https://firebasestorage.googleapis.com/v0/b/himanshuchat-e421d.appspot.com/o/quickchat.png?alt=media&token=eb647c63-339b-436e-ad90-0db3e30a905b') : NetworkImage(furl)))  ),
                ],
              ),
               // child: imagefilepath == null ? Text('sel ur image') : Image.network(furl))
          //      : Image.file(imagefilepath),
          ),
    );
  }
}
