import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final dynamic item;

  ProductDetailPage({this.item});

  @override 
  Widget build(BuildContext context) {
    final String pictureUrl = 'https://c1ae95c93e47.ngrok.io${item['picture'][0]['url']}';

    return Scaffold(
      appBar: AppBar(
        title: Text(item['name'])
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Image.network(pictureUrl, fit: BoxFit.cover)
            ),
            Text(item['name'], style: Theme.of(context).textTheme.headline6),
            Text('R\$${item['price']}', style: Theme.of(context).textTheme.bodyText1),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  child: Text(item['description']),
                  padding: EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0)
                )
              )
            )
          ],
        ),
      )
    );
  }
}