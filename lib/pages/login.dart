import 'package:ecommerce_app/routes/routing/router.dart' as router;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  /// Variable to be supplied with navigator argument
  var username;
  Map<String, String> data = {};

  bool isHidden = true;

  /// Global Key to handling form
  final _formKey = GlobalKey<FormState>();

  /// Text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /// To remove focus from text input fields on submit tap
  late FocusNode _emailFocusNode, _passwordFocusNode;

  @override
  void initState() {
    /// Initializing FocusNode instances
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    /// Free memory by disposing FocusNode instances
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  bool login(Map userData) {
    if (userData['username'] == "flutter@ennovations.com" &&
        userData['password'] == "Flutter@1122021")
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    /// Dimension Constraints
    double height = MediaQuery.of(context).size.height;
    double safeHeight = height - MediaQuery.of(context).padding.top;
    double width = MediaQuery.of(context).size.width;
    /*_emailController.text = "flutter@ennovations.com";
    _passwordController.text = "Flutter@1122021";*/

    return SafeArea(
        child: Scaffold(
      body: Container(
          height: safeHeight,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: width * 0.05),
          //color: Colors.blue,
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    focusNode: _emailFocusNode,
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username cannot be empty';
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return 'Please a valid Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: width * 0.05,
                  ),
                  TextFormField(
                    focusNode: _passwordFocusNode,
                    controller: _passwordController,
                    maxLength: 20,
                    obscureText: isHidden,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(isHidden
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            }),
                        hintText: '*******',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: width * 0.1,
                  ),
                  Container(
                    height: width * 0.12,
                    width: width * 0.3,
                    child: ElevatedButton(
                      onPressed: () {
                        _emailFocusNode.unfocus();
                        _passwordFocusNode.unfocus();
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          /// Wrap data into map
                          data = {
                            'username': _emailController.text,
                            'password': _passwordController.text
                          };

                          /// Call login function
                          var result = login(data);
                          if (result) {
                            Navigator.pushNamed(context, router.Router.home,
                                arguments: username);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Wrong credentials')),
                            );
                          }
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ))),
    ));
  }
}
