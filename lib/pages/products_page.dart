import 'dart:convert';

import 'package:app/models/app_state.dart';
import 'package:app/widgets/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsPage extends StatefulWidget {
  final void Function() onInit;

  ProductsPage({this.onInit});

  @override 
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  void initState() {
    super.initState();

    widget.onInit();
  }

  final _appBar = PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    child: StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return AppBar(
          centerTitle: true,
          title: SizedBox(child: state.user != null ? Text(state.user.username) : Text('')),
          leading: Icon(Icons.store),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: state.user != null ? IconButton(icon: Icon(Icons.exit_to_app), onPressed: () => print('pressed')) : Text('')
            )
          ]
        );
      }
    ),
  );

  @override 
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: _appBar,
      body: Container(
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state) {
            return Column(
              children: [
                Expanded(
                  child: SafeArea(
                    top: false,
                    bottom: false,
                    child: GridView.builder(
                      itemCount: state.products.length,
                      padding: EdgeInsets.all(20.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: orientation == Orientation.portrait ? 1.0 : 1.3 
                      ),
                      itemBuilder: (context, i) => ProductItem(item: state.products[i])
                    )
                  )
                )
              ],
            );
          }
        )
      )
    );
  }
}