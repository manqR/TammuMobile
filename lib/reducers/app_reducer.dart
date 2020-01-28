export 'package:myapp/models/app_state.dart';
import 'package:myapp/models/app_state.dart';
import 'package:myapp/reducers/loading_reducer.dart';
import 'package:myapp/reducers/product_reducer.dart';

AppState appReducer(AppState state, action){

  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    products: productReducer(state.products, action),
    product: oneProductReducer(state.product, action),
    transactions: transactionRecuder(state.transactions, action),
    bills: billRecuder(state.bills, action),
    insertedBill: oneBillReducer(state.insertedBill, action),
    query: queryReducer(state.query, action),
    idBill: idLastInseted(state.idBill, action)
  );
  
}