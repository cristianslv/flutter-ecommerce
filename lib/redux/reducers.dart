import 'package:app/models/app_state.dart';
import 'package:app/models/user.dart';

import 'actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: userReducer(state.user, action),
    products: productsReducer(state.products, action)
  );
}

User userReducer(User user, dynamic action) {
  if (action is GetUserAction) {
    // return user from action

    return action.user;
  }

  return user;
}

productsReducer(products, action) {
  if (action is GetProductsAction) {
    // return products from action

    return action.products;
  }
  
  return products;
}