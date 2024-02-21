import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final dio = Dio();
  final _formKey = GlobalKey<FormState>();
  TextEditingController loginIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future login() async {
    try {
      final response = await dio.post(
        "https://reqres.in/api/login",
        data: {
          //"email": "eve.holt@reqres.in",
          //"password": "cityslicka"
          "email":loginIdController.text,
         "password":passwordController.text,
      },
        options: Options(
          receiveTimeout: const Duration(seconds: 3),
        ),
      );
      if (response.statusCode == 200){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('login successfully'),
          duration: Duration(seconds: 7),
        )
        );
        //Navigator.of(context).pushNamed('/secondpage');
        debugPrint('---->${response.data}');
        loginIdController.text = '';
        passwordController.text = '';
      }else{
        debugPrint('statusCode----> ${response.statusCode}');
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('invalid details')));
      debugPrint('error at login $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: TextFormField(
                          validator: (value){
                            if (value == null || value.isEmpty){
                              return 'please enter loginId';
                            }
                             return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Login',
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(Icons.login),
                            prefixIconColor: Colors.black,
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            filled: true,
                          ),
                          controller: loginIdController,
                        ),
                      ),
                      Padding(padding: const EdgeInsets.all(30),
                        child: TextFormField(
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'please enter password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(Icons.password),
                            prefixIconColor: Colors.black,
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            filled: true,
                          ),
                          controller: passwordController,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        elevation: 10,
                        shape: StadiumBorder(),
                      ),
                      onPressed: (){
                        SnackBar(
                          content: Text('please enter the LoginId and Password'),
                        );
                        FocusManager.instance.primaryFocus?.unfocus();
                        if(_formKey.currentState!.validate()){
                          login();
                        }
                        Navigator.pushNamed(context, '/secondpage');
                      },
                      child: Text('login'),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
