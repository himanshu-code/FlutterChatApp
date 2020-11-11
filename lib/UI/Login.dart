import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class MyLogin extends StatefulWidget{
@override
_MyLoginState createState()=> _MyLoginState();
}


class _MyLoginState extends State<MyLogin>{
  var authc = FirebaseAuth.instance;

  String email;
  String password;
  bool sspin = false;
  
@override
Widget build(BuildContext context){
  var Homeicon=Icon(Icons.home,color: Colors.grey,);
  var HomeButton=IconButton(icon: Homeicon, onPressed: null);
  var logo=Image.network("https://firebasestorage.googleapis.com/v0/b/himanshuchat-e421d.appspot.com/o/quickchat.png?alt=media&token=eb647c63-339b-436e-ad90-0db3e30a905b");
var appbar=AppBar(leading: logo, title: Text("User Login"),actions: <Widget>[HomeButton],backgroundColor: Colors.black);
var myhome=Scaffold(appBar: appbar,
                    body:ModalProgressHUD(
        inAsyncCall: sspin,
        child: Center(
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
                    icon: Icon(Icons.mail,color: Colors.blue,)
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
                    icon: Icon(Icons.lock,color: Colors.blue,)
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
                    child: Text('Login'),
                    onPressed: () async {
                      setState(() {
                        sspin = true;
                      });

                      try {
                        var userSignin = await authc.signInWithEmailAndPassword(
                            email: email, password: password);
                        print(userSignin);

                        if (userSignin != null) {
                          Navigator.pushNamed(context, "chat");
                          setState(() {
                            sspin = false;
                          });
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
      ), 
      backgroundColor: Colors.black,
                    );

var design=MaterialApp(home: myhome,debugShowCheckedModeBanner: false,);

return design;
}
}