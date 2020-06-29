import 'package:brew_cafe/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_cafe/models/brew.dart';
import 'package:brew_cafe/services/database.dart';
import 'package:brew_cafe/screens/home/brew_list.dart';
import 'package:brew_cafe/screens/home/settings_form.dart';

class Home extends StatelessWidget {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(backgroundColor: Colors.brown[200], shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),),context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
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
                _showSettingsPanel();
              },
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
            FlatButton.icon(
              onPressed: () async{
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Logout'),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )
          ),
          child: BrewList()
        ),
      ),
    );
  }
}
