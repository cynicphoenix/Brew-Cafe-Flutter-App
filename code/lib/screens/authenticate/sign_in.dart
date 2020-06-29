import 'package:brew_cafe/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_cafe/shared/constant.dart';
import 'package:brew_cafe/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // To use auth services
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  // Store email & password locally
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Brew Cafe'),
        elevation: 0.0,
        backgroundColor: Colors.brown[600],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Register'),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 25.0),
              TextFormField(
                decoration: TextInputDecoration.copyWith(hintText: 'Email'),
                validator: (value) => value.isEmpty ? 'Enter email id' : null,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(height: 25.0),
              TextFormField(
                decoration: TextInputDecoration.copyWith(hintText: 'Password'),
                validator: (value) => value.length < 7 ? 'Password must be atleast 8 characters' : null,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(height: 25.0),
              ButtonTheme(
                height: 40.0,
                minWidth: 100.0,
                child: RaisedButton(
                  onPressed: () async{
                    if(_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null) {
                        print('Invalid credentials');
                        setState(() {
                          error = 'Invalid Credentials';
                          loading = false;
                        });
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.red)
                  ),
                  color: Colors.pink,
                  child: Text(
                    'Sign-In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
