import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/pages/Signup.dart';

import 'login.dart';

class forgotpass extends StatefulWidget {


  @override
  State<forgotpass> createState() => _forgotpassState();
}

class _forgotpassState extends State<forgotpass> {
  final _formkey = GlobalKey<FormState>();
  var email = "";

  final emailController= TextEditingController();
  resetPassword()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.amber ,
        content: Text('Password Reset Email has been sent',style: TextStyle(fontSize: 18.0),),
      ),

      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> loginPage(), ),);


    }on FirebaseAuthException catch(error){
      if(error.code=='user-not-found'){
        print('No user found for this email');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.amber ,
          content: Text('No user found for this email',style: TextStyle(fontSize: 18.0,color: Colors.amber),),
        ),

        );
      }

    }
  }
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Reset password'),
      ),
      body: Column(
        children: [
          Padding(padding:const EdgeInsets.all(20.0),
          ),
          Container(
            margin:EdgeInsets.only(top: 20.0) ,
            child: Text('Reset link will be sent to your email ',style: TextStyle(fontSize: 20.0),
            ),

          ),
          Expanded(child: Form(
            key: _formkey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical:10.0,horizontal:30.0  ),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.black,
                    fontSize: 15,),

                    ),
                      controller: emailController,
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return "please enter email";
                        }
                        else if (!value.contains('@')){
                          return "please enter valid email";
                        }
                        return null;
                      },

                  ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical:20.0),
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: (){
                          if(_formkey.currentState!.validate()){
                              setState(() {
                                email = emailController.text;
                              });
                              resetPassword();
                          }
                        },
                            child: Text('send email',style: TextStyle(fontSize: 18.0),),
                        ),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> loginPage(),),);
                        },
                            child: Text('Login',style: TextStyle(fontSize: 13.0),),
                        ),


                      ],




                    ),

                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('do not have an account?'),
                        TextButton(onPressed: (){
                          Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context,a,b)=>Signup(),
                          transitionDuration: Duration(seconds: 0),), (route) => false);
                          

                          
                        }, child: Text('sign up',),
                        ),
                      ],
                    ),
                  ),
                ],

              ),
            ),
          ))
          
        ],
      ),

    );
  }
}
