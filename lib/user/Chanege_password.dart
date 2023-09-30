
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/pages/login.dart';

class Changepass extends StatefulWidget {


  @override
  State<Changepass> createState() => _ChangepassState();
}

class _ChangepassState extends State<Changepass> {
  final _formkey = GlobalKey<FormState>();
  var newPassword = " ";

  final newPasswordController= TextEditingController();
  @override
  void dispose() {
   newPasswordController.dispose();
    super.dispose();
  }
  final currentUser= FirebaseAuth.instance.currentUser;
  changePassword()async{
    try{
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginPage(),),);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black26 ,
        content: Text('Your password has been changed.. Login again !',style: TextStyle(fontSize: 20.0),),
      ),

      );

    }catch(error){

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 25.0),
          child: ListView(
            children: [
              SizedBox(height: 100,),
              Padding(
                  padding:const EdgeInsets.all(10.0),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle:
                      TextStyle(color: Colors.black,fontSize: 15.0),
                    ),
                    controller: newPasswordController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return'Please enter Password';

                      }

                      return null;
                    },
                  )
              ),
              ElevatedButton(onPressed: (){
                if(_formkey.currentState!.validate()){
                  setState(() {
                    newPassword = newPasswordController.text;

                  });
                  changePassword();
                }
              }, child: Text('Change Password',style: TextStyle(fontSize: 20.0),),),
            ],
          ),
        ) ,
      ),

    );
  }
}
