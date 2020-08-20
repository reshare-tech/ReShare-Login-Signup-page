

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/signinpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

import 'MainPage.dart';
class loginPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return login();
  }

}
class login extends State<loginPage>
{bool _isLoading = false;

  TextEditingController _username=TextEditingController();
  TextEditingController _password=TextEditingController();
signIn(String email, pass) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //String url="http://192.168.1.85:8000/api/auth/login";
  String url="http://192.168.1.85:8000/signin";
Map json1 = {"email":email,"password":pass};
var body=jsonEncode(json1);
  Map<String, String> headers = {"Content-type": "application/json"};
  var jsonResponse = null;
  var response = await http.post(url, body: body,headers: headers,);
  if(response.statusCode == 200) {
    jsonResponse = jsonDecode(response.body);
    if(jsonResponse != null) {
      setState(() {
        _isLoading = false;
      });
      sharedPreferences.setString("token", jsonResponse['token']);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);

    }
  }
  else {
    setState(() {
      _isLoading = false;
    });
    print(response.body);
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
     body:VxBox(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           SizedBox(
             height: 80,
           ),
           "Login".text.size(40).white.make().pLTRB(10,0,0,0),
           SizedBox(
             height: 12,
           ),
           "Welcome back".text.size(20).white.make().pLTRB(10,0,0,0),
           SizedBox(
             height: 19,
           ),
           Expanded(
             child: VxBox(
               child: Column(
                 children: <Widget>[

                   SizedBox(
                     height: 125,
                   ),
                   VxBox(
                     child: TextField(
                       controller: _username,
                       cursorColor: Colors.black,
                       decoration: InputDecoration(
                         border: InputBorder.none,
                         hintText:"  Username",
                         hintStyle: TextStyle(color: Colors.grey),
                         focusColor: Colors.black,
                         hoverColor: Colors.black

                       ),

                     )
                   ).neumorphic(color: Colors.white,elevation: 12.0).shadow2xl.roundedLg.make().centered().wh(330,50),
                   SizedBox(
                     height: 10,
                   ),
                   VxBox(
                       child: TextField(
                         controller: _password,
                         cursorColor: Colors.black,
                         obscureText: true,
                         decoration: InputDecoration(
                             border: InputBorder.none,
                             hintText:"  Password",
                             hintStyle: TextStyle(color: Colors.grey),
                             focusColor: Colors.black,
                             hoverColor: Colors.black,


                         ),
                       )
                   ).neumorphic(color: Colors.white,elevation: 7.0).roundedLg.make().centered().wh(330,50),

                   SizedBox(
                     height: 15,
                   ),
                   VxBox(
                     child: MaterialButton(
                       child: "Login".text.white.make(),

                       onPressed:()
                         {print(_username.text);

                         print(_password.text);
                           setState(() {
                             _isLoading=true;
                           });
                           signIn(_username.text,_password.text);
                         }
                     )
                   ).color(Colors.orange).roundedLg.make().wh(200,40),
                   SizedBox(
                     height: 10,
                   ),
                   VxBox(
                     child: "Not yet registerd".text.size(16).gray700.makeCentered()
                   ).makeCentered(),
                   SizedBox(
                     height: 12,
                   ),
                   VxBox(
                     child: MaterialButton(
                       child: "Click to Register".text.white.makeCentered(),
                       onPressed: ()
                       {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>signPage()));
                       },
                     )
                   ).roundedLg.color(Colors.amber ).make().wh(200,40)
                 ],
               )
             ).white.withDecoration(BoxDecoration(color:Colors.white,borderRadius: BorderRadius.only(topLeft:Radius.circular(46),topRight: Radius.circular(46)))).shadow2xl.
             make().w(400),
           )
         ],

       )
     ).linearGradient([Vx.orange400,Vx.orange300]).make().w(400)
    );
  }

}



