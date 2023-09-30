import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/pages/Signup.dart';
import 'package:untitled5/pages/user_main.dart';

import 'forgot_password.dart';
class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _formkey =GlobalKey<FormState>();
  var email ="";
  var password ="";
  final emailController =TextEditingController();
  final passwordController =TextEditingController();
  useLogin() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Usermain()));

    }on FirebaseAuthException catch(error){
      if(error.code=='user-not-found'){
        print('NO user found for this email');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text('NO user found for this email',style:TextStyle(fontSize: 18.0,color: Colors.amber) ,)
          ,
        ),
        );
      }
      else if(error.code == 'wrong-password'){
        print('wrong password provided by the user ');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text('wrong password provided by the user',style:TextStyle(fontSize: 18.0,color: Colors.amber) ,)
          ,
        ),
        );
      }

    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 60.0,horizontal: 20.0),
          child: ListView(
            children: [
              Padding(padding:const EdgeInsets.all(8.0),

              ),
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
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.black,
                      fontSize: 15,),

                  ),
                  controller: passwordController,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "please enter password";
                    }

                    return null;
                  },


                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed:(){
                      if(_formkey.currentState!.validate()){
                        setState(() {
                          email = emailController.text;
                          password =passwordController.text;

                        });
                        useLogin();

                      }
                    },
                         child: Text(
                           "login",
                           style: TextStyle(fontSize: 18.0),
                         ),
                    ),
                    TextButton(onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> forgotpass(),),
                      );

                    },
                        child: Text(
                          "forgot password ?",
                          style: TextStyle(fontSize: 12.0),
                        ),
                    ),
                  ],
                ),

              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Do not have an account?"),
                    TextButton(onPressed:(){
                      Navigator.pushAndRemoveUntil(context,PageRouteBuilder(pageBuilder: (context,a,b)=>Signup(),transitionDuration: Duration(seconds: 0)), (route)=> false);

                    }
                        , child: Text("Sign up"),
                    )
                  ],
                ),
              ),

              
            ],
          ),

      ),
      ),
    );
  }
}
