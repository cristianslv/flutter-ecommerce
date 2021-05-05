import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {
  @override

  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  String _username, _email, _password;

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      print("Username: $_username, Email: $_email, Password: $_password");
    }
  }

  Widget _showTitle() {
    return Text("Register", style: Theme.of(context).textTheme.headline1);
  } 

  Widget _showUsernameInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _username = val,
        validator: (val) => val.length < 6 ? "Username too short" : null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Username",
          hintText: "Enter username, min length 6"
        ),
      ),
    );
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
          RaisedButton(
            child: Text("Submit", style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: Colors.black
            )),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            color: Theme.of(context).primaryColor,
            onPressed: () => _submit(),
          ),
          FlatButton(
            child: Text("Existing User? Login"),
            onPressed: () => Navigator.pushReplacementNamed(context, "/login"),
          )
        ],
      ),
    );
  }

  

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _showTitle(),
                  _showUsernameInput(),
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