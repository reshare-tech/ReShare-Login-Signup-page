

import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class signPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return sign();
  }

}
class sign extends State<signPage>
{
var jsonResponse;
  bool _isLoading = false;

  TextEditingController _username=TextEditingController();
  TextEditingController _password=TextEditingController();
  TextEditingController _email=TextEditingController();
  signIn(String user, email1,pass1) async {
    String email=email1.toString();
    String pass=pass1.toString();
    print(email);
    print(email);
    print(pass);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   // String url="http://192.168.1.85:8000/api/auth/register";
    String url="http://192.168.1.85:8000/signup";
    Map json2= {"name":user,"email":email,"password":pass};
    var json1=json.encode(json2);
    print(json1);
     jsonResponse = null;
    Map<String, String> headers = {"Content-type": "application/json"};
    var response = await http.post(url, body: json1,headers: headers);
    if(response.statusCode == 200) {
      jsonResponse = jsonDecode(response.body);
      if(jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        print("You have been registered");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => loginPage()), (Route<dynamic> route) => false);
      //Navigator.pop(context);
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
                "SignIn".text.size(40).white.make().pLTRB(10,0,0,0),
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
                            height: 100,
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
                                cursorColor: Colors.black,
                                controller: _email,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText:"  Email_Id",
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
                            height: 12,
                          ),
                          VxBox(
                              child: MaterialButton(
                                child: "Click to Register".text.white.makeCentered(),
                                onPressed: ()
                                {Flushbar(
                                    title:  "Hey User",
                                    message:  "You are Registered going to login page",
                                    duration:  Duration(seconds: 15),
                                  )..show(context);
                                  setState(() {
                                    _isLoading=true;
                                  });
                                  signIn(_username.text, _email.text,_password.text);

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