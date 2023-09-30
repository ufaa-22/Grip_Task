import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/pages/login.dart';

class Signup extends StatefulWidget {


  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formkey = GlobalKey<FormState>();
  var email = "";
  var password ="";
  var confirmpassword ="";
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
   confirmpasswordController.dispose();
    super.dispose();
  }
  final emailController= TextEditingController();
  final passwordController= TextEditingController();
  final confirmpasswordController= TextEditingController();
  registration()async{
    if(password== confirmpassword){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey ,
          content: Text('Registred successfully. please sign in',style: TextStyle(fontSize: 20.0),),
        ),

        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> loginPage(), ),);
        
     

      }on FirebaseAuthException catch(error){
        if(error.code=='weak-password' ){
          print('password is too weak ');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black ,
            content: Text('password is too weak',style: TextStyle(fontSize: 20.0,color: Colors.amberAccent),),
          ),

          );

        }
        else if(error.code == 'email-already-in-use'){
          print('Account is already exists ');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black ,
            content: Text('Account is already exists ',style: TextStyle(fontSize: 20.0,color: Colors.amberAccent),),
          ),

          );


        }

    }
    }
    else{
      print('password and confirm password does not match');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black ,
        content: Text('password and confirm password does not match ',style: TextStyle(fontSize: 20.0,color: Colors.amberAccent),),
      ),

      );

    }
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
              Padding(
                  padding:const EdgeInsets.all(30.0),

              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                      TextStyle(color: Colors.black,fontSize: 15.0),

                  ),
                  controller: emailController,
                    validator: (value){
                    if(value == null || value.isEmpty){
                      return'please enter email';

                    }
                    else if (!value.contains('@')){
                      return 'please enter valid email';

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
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.black,fontSize: 15.0),
              ),
                  controller: passwordController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return'please enter password';

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
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.black,fontSize: 15.0),
                  ),
                  controller: confirmpasswordController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return'please confirm password';

                    }

                    return null;
                  },
                ),

              ),
              SizedBox(height: 15,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      if(_formkey.currentState!.validate()){
                        setState(() {
                          email = emailController.text;
                          password= passwordController.text;
                          confirmpassword= confirmpasswordController.text;
                        });
                        registration();


                      }
                    },
                        child: Text('Signup',style: TextStyle(fontSize: 18.0),),),

                  ],
                ),
                
              ),
              SizedBox(height: 15,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('alredy have an account ?'),
                    TextButton(onPressed: (){
                      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context,animation1,animation2)=>loginPage(),
                      transitionDuration:Duration(seconds: 0),),);
                      
                    }, child: Text('login'),),

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
