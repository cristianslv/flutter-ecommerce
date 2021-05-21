import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class LoginPage extends StatefulWidget {
  @override

  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _isSubmitting, _obscureText = true;

  String _email, _password;

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      _registerUser();
    }
  }

  Widget _showTitle() {
    return Text("Login", style: Theme.of(context).textTheme.headline1);
  } 

  Widget _showEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _email = val,
        validator: (val) => !val.contains("@") ? "Invalid email" : null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Email",
          hintText: "Enter a valid email"
        ),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _password = val,
        validator: (val) => val.length < 6 ? "Username too short" : null,
        obscureText: _obscureText,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() => _obscureText = !_obscureText);
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off)
          ),
          border: OutlineInputBorder(),
          labelText: "Password",
          hintText: "Enter password, min length 6"
        ),
      ),
    );
  }

  Widget _showFormActions() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          _isSubmitting == true ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor)) : RaisedButton(
            child: Text("Submit", style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: Colors.black
            )),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            color: Theme.of(context).accentColor,
            onPressed: () => _submit(),
          ),
          FlatButton(
            child: Text("New User? Register"),
            onPressed: () => Navigator.pushReplacementNamed(context, "/register"),
          )
        ],
      ),
    );
  }

  void _registerUser() async {
    setState(() {
      _isSubmitting = true;
    });
    
    http.Response response = await http.post("https://4e369fa0a681.ngrok.io/auth/local", body: {
      "identifier": _email,
      "password": _password
    });

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        _isSubmitting = false;
      });

      _storeUserData(responseData);

      _showSuccessSnack();
      _redirectUser();

      print(responseData);
    } else {
      setState(() {
        _isSubmitting = false;
      });

      final String errorMessage = responseData['message'][0]['messages'][0]['message'];

      _showErrorSnack(errorMessage);
    }
  }

  void _storeUserData(responseData) async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> user = responseData['user'];

    user.putIfAbsent('jwt', () => responseData['jwt']);

    prefs.setString('user', json.encode(user));
  }

  void _showSuccessSnack() {
    final snackbar = SnackBar(
      content: 
      Text("User successfully logged in!", 
        style: TextStyle(
          color: Colors.green
        ),
      )
    );

    _scaffoldKey.currentState.showSnackBar(snackbar);
    _formKey.currentState.reset();
  }

  void _showErrorSnack(String errorMessage) {
    final snackbar = SnackBar(
      content: 
      Text(errorMessage, 
        style: TextStyle(
          color: Colors.red
        ),
      )
    );

    _scaffoldKey.currentState.showSnackBar(snackbar);
    // throw Exception("Error logging in: $errorMessage");
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/products');
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Login")),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _showTitle(),
                  _showEmailInput(),
                  _showPasswordInput(),
                  _showFormActions()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}