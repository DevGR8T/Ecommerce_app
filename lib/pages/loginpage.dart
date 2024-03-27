import 'package:ecommerce_app/pages/rootpage.dart';
import 'package:ecommerce_app/services/apiservices.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController namecontroller =
      TextEditingController(text: 'kminchelle');
  TextEditingController passwordcontroller =
      TextEditingController(text: '0lelplR');
  bool hidepassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Shop'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formkey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      'WELCOME BACK!',
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: namecontroller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field is Required';
                      } else if (value.length < 5) {
                        return 'Not less than 5 characters';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Username',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Color.fromARGB(115, 132, 91, 91),
                                width: 1.5)),
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is Required';
                      } else if (value.length < 5) {
                        return 'Weak password';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordcontroller,
                    obscureText: hidepassword,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidepassword = !hidepassword;
                              });
                            },
                            icon: hidepassword == true
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Color.fromARGB(115, 132, 91, 91),
                                width: 1.5)),
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10),
                  Text('Forgot Password?'),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 35),
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(25)),
                      child: TextButton(
                        onPressed: () async {
                          final logindetails = await Apiservice().postuserlogin(
                              namecontroller.text, passwordcontroller.text);
                          if (logindetails["username"] != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Login successful',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              backgroundColor: Colors.green,
                            ));
                            Future.delayed(Duration(seconds: 1), () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RootPage(),
                                  ));
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Incorrect username or password',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: Colors.red,
                            ));
                          }
                          formkey.currentState!.validate();
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ))
                ]),
          ),
        ),
      ),
    );
  }
}
