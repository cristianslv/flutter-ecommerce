import 'package:app/models/app_state.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/products_page.dart';
import 'package:app/pages/register_page.dart';
import 'package:app/redux/reducers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'redux/actions.dart';

void main() {
  final store = Store<AppState>(appReducer, initialState: AppState.initial(), middleware: [thunkMiddleware]);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
      title: 'Flutter E-commerce',
      routes: {
        '/products': (BuildContext context) => ProductsPage(
          onInit: () {
            // dispatch an action (getUserAction)  to grab the user data

            StoreProvider.of<AppState>(context).dispatch(getUserAction);
          }
        ),
        '/login': (BuildContext context) => LoginPage(),
        '/register': (BuildContext context) => RegisterPage()
      },
      theme: ThemeData(
        primaryColor: Colors.blue[100],
        accentColor: Colors.lightBlue[500],
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 18.0)
        )
      ),
      home: RegisterPage(),
    ));
  }
}
