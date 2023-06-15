import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/loginpage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  final _regKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // email
      //password
      //confirm password
      //name
      //phone
      //button

      // form-column-

      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: _regKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a valid email";
                    }
                  },
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a valid Name";
                    }
                  },
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Name",
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a valid Password";
                    }
                  },
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: "Phone",
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a valid password";
                    }
                  },
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    if (_regKey.currentState!.validate()) {
                      if (_passwordController.text ==
                          _confirmPasswordController.text) {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailController.text.trim(),
                                password: _passwordController.text)
                            .then((value) {
                          FirebaseFirestore.instance
                              .collection('user')
                              .doc(value.user!.uid)
                              .set({
                            "email": value.user!.email,
                            "name": _nameController.text,
                            "phone": _phoneController.text,
                            "createdat": DateTime.now(),
                            "status": 1,
                            "password": _passwordController.text
                          }).then((value) {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPAge()));

                          });
                        }) ;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Password Miss match")));
                      }
                    }
                  },
                  child: Container(
                    height: 45,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text("Register"),
                    ),
                  ),
                ),


                Row(
                  children: [

                    Text("Already have an account?"),
                    InkWell(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPAge()));
                      },
                        child: Text("Login"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
