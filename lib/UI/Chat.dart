import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'my_image.dart';

class MyChat extends StatefulWidget {
  @override
  _MyChatState createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  var msgtextcontroller = TextEditingController();

  var fs = FirebaseFirestore.instance;
  var authc = FirebaseAuth.instance;

  String chatmsg;

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var signInUser = authc.currentUser.email;
    var sendIcon=Icon(Icons.send,color: Colors.purpleAccent);
    var UserIcon=IconButton(icon: Icon(Icons.people,color:Colors.grey),onPressed:(){ Navigator.pushNamed(context,'myimage' );},);
var Homeicon=Icon(Icons.home,color: Colors.blue,);
  var HomeButton=IconButton(icon: Homeicon, onPressed:(){ Navigator.pushNamed(context, "home");});
  var logo=Image.network("https://firebasestorage.googleapis.com/v0/b/himanshuchat-e421d.appspot.com/o/quickchat.png?alt=media&token=eb647c63-339b-436e-ad90-0db3e30a905b");
var appbar=AppBar(leading: logo, title: Text("Chats"),actions: <Widget>[HomeButton,UserIcon],backgroundColor: Colors.black,);
    return Scaffold(
        appBar: appbar,
        backgroundColor: Colors.black,
        body: Container(//color: Colors.black,
        alignment: Alignment.topLeft,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft:Radius.circular(15),topRight:Radius.circular(15))),
          margin: EdgeInsets.only(top:15),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    StreamBuilder<QuerySnapshot>(
                       stream: fs.collection("chat").orderBy('time').snapshots(),
                      builder: (context, snapshot) {
                        print('new data comes');
                         var msg =(snapshot.data.docs==null)? null: snapshot.data.docs;
                        
                       // if(msg==null) return CircularProgressIndicator();
                        // print(msg);
                        // print(msg[0].data());
                        List<Widget> y = [];
                                              
                        for (var d in msg) {
                          // print(d.data()['sender']);
                          var msgText = (d.data==null)? null:d.data()['text'];
                          var msgSender = (d.data==null)? null:d.data()['sender'];
                          var msgtime=(d.data==null)? null:d.data()['time'] ;
                          var sendshape=RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20),bottomLeft: Radius.circular(20) ) );
                          var recvshape=RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20),bottomRight: Radius.circular(20) ) );
                          var msgWidget = Padding(padding: EdgeInsets.all(5) ,child:Column( crossAxisAlignment: (signInUser==msgSender)?CrossAxisAlignment.end :CrossAxisAlignment.start ,mainAxisSize: MainAxisSize.min ,children: <Widget>[
                            MaterialButton( elevation: 30,shape:(signInUser==msgSender)?sendshape:recvshape ,color:Colors.grey ,disabledColor: (signInUser==msgSender)?Colors.red : Colors.blue ,padding: EdgeInsets.all(15), child: Text("$msgText  ",style: TextStyle(color: Colors.black ,fontWeight: FontWeight.w700),), onPressed: null,),
                            Text("$msgSender $msgtime", style: TextStyle(color: Colors.purpleAccent ,fontWeight: FontWeight.bold),),
                            
                          ],
                          ));

                          y.add(msgWidget);
                        }
                        print(y);
                         
                        return Container( margin: EdgeInsets.only(top:15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            
                            children: y,
                          ),
                        );
                      },
                     
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                      color: Colors.black,
                    width: deviceWidth * 0.85,
                    child: TextField(
                      controller: msgtextcontroller,
                      decoration: InputDecoration(icon: Icon(Icons.message,color: Colors.purpleAccent,) ,hintText: 'Enter msg ..',fillColor: Colors.white, filled: true,enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(40),),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                      onChanged: (value) {
                        chatmsg = value;
                      },
                    ),
                  ),
                  Container(color: Colors.black,
                  height: 59,
                  width: deviceWidth*0.15,
                    child: IconButton(icon: sendIcon ,color: Colors.black,focusColor: Colors.black,highlightColor:Colors.black,disabledColor: Colors.black , onPressed:() async {
                          msgtextcontroller.clear();

                          await fs.collection("chat").add({
                            "text": chatmsg,
                            "sender": signInUser,
                            "time": DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now()),
                          });
                          print(signInUser);
                        } ),
                  ),
                ],

              ),

            ],
          ),
        ),
     
        );
  }
}
