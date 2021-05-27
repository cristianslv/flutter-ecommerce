import 'package:app/models/app_state.dart';
import 'package:app/pages/product_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProductItem extends StatelessWidget {
  final dynamic item;

  ProductItem({this.item});

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = 'https://c1ae95c93e47.ngrok.io${item['picture'][0]['url']}';

    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return ProductDetailPage(item: item);
        })
      ),
      child: GridTile(
        footer: GridTileBar(
          title: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(item['name'], style: TextStyle(fontSize: 14.0))
          ),
          subtitle: Text("R\$${item['price']}", style: TextStyle(fontSize: 10.0)),
          backgroundColor: Colors.grey[400],
          trailing: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (_, state) {
              return state.user != null ? 
                IconButton(icon: Icon(Icons.shopping_cart), color: Colors.white, onPressed: () => print("pressed")) : Text(''); 
            },
          ),
        ),
        child: Image.network(pictureUrl, fit: BoxFit.cover, alignment: Alignment.topCenter)
      )
    );
  }
}