import "package:flutter/material.dart";

class MyHome extends StatefulWidget{
@override
_MyHomeState createState()=> _MyHomeState();
}
class _MyHomeState extends State<MyHome>{
  @override
  Widget build(BuildContext context){
     var Homeicon=Icon(Icons.home,color: Colors.grey,);
  var HomeButton=IconButton(icon: Homeicon, onPressed: null);
  
  var logo=Image.network("https://firebasestorage.googleapis.com/v0/b/himanshuchat-e421d.appspot.com/o/quickchat.png?alt=media&token=eb647c63-339b-436e-ad90-0db3e30a905b");
  var loginButton=MaterialButton(onPressed:(){ Navigator.pushNamed(context, "login"); },minWidth: 150,color: Colors.black, textColor: Colors.white,padding: EdgeInsets.all(20),splashColor: Colors.red,child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 25),),);
  var registerButton=MaterialButton(onPressed:(){ Navigator.pushNamed(context, "reg"); },minWidth: 150,color: Colors.black, textColor: Colors.white,padding: EdgeInsets.all(20),splashColor: Colors.red,child: Text("Register",style: TextStyle(color: Colors.white,fontSize: 25),),);
  var container=Container(alignment: Alignment.bottomCenter,
                          //margin: EdgeInsets.all(10),
                          height: 320,
                          width: 320,
                          //padding: EdgeInsets.all(100),
                          decoration: BoxDecoration(color: Colors.deepPurple,borderRadius: BorderRadius.only(topLeft: Radius.circular(90),topRight: Radius.circular(90),bottomLeft: Radius.circular(90)),),
                          child: Column( mainAxisAlignment: MainAxisAlignment.center,

                                         children: <Widget>[Container(margin: EdgeInsets.all(10),child: loginButton),
                                         Container(margin: EdgeInsets.all(10),child: registerButton),
                                         ],

                          ),
                          );
  var appbar=AppBar(leading: logo, title: Text("Welcome to QuickChat"),actions: <Widget>[HomeButton],backgroundColor: Colors.black);
  var myHome=Scaffold(appBar: appbar,body: Center(child: container), backgroundColor: Colors.black,);
  var design=MaterialApp(home:myHome,debugShowCheckedModeBanner: false,);
  return design;
  }

}