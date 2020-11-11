import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
class MyReg extends StatefulWidget{
@override
_MyRegState createState()=> _MyRegState();
}


class _MyRegState extends State<MyReg>{
  var authc = FirebaseAuth.instance;

  String email;
  String password;
  
  
@override
Widget build(BuildContext context){
  var Homeicon=Icon(Icons.home,color: Colors.grey,);
  var HomeButton=IconButton(icon: Homeicon, onPressed: null);
  var logo=Image.network("https://firebasestorage.googleapis.com/v0/b/himanshuchat-e421d.appspot.com/o/quickchat.png?alt=media&token=eb647c63-339b-436e-ad90-0db3e30a905b");
var appbar=AppBar(leading: logo, title: Text("User Registration"),actions: <Widget>[HomeButton],backgroundColor: Colors.black);
var myhome=Scaffold(appBar: appbar,
                    body:Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  icon: Icon(Icons.mail,color:Colors.blue)
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  icon: Icon(Icons.lock,color:Colors.blue)
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(10),
                elevation: 10,
                child: MaterialButton(
                  minWidth: 100,
                  height: 40,
                  child: Text('Submit'),
                  onPressed: () async {
                    try {
                      var user = await authc.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      print(email);
                      print(password);
                      print(user);

                      if (user.additionalUserInfo.isNewUser == true) {
                        Navigator.pushNamed(context, "chat");
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
                    );

var design=MaterialApp(home: myhome,debugShowCheckedModeBanner: false,);

return design;
}
}