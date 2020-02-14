import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:myapp/actions/action.dart';
// import 'package:myapp/models/app_route.dart';
import 'package:myapp/models/app_state.dart';
// import 'package:myapp/presentation/detail_bill.dart';
// import 'package:myapp/presentation/form_product.dart';
// import 'package:myapp/presentation/form_transaction.dart';
// import 'package:myapp/presentation/home_screen.dart';
import 'package:myapp/reducers/app_reducer.dart';
import 'package:myapp/middleware/app_middleware.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:myapp/constants/constants.dart';
import 'package:myapp/presentation/signin.dart';

void main() {
 Stetho.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final store = Store<AppState>(
      appReducer,
      initialState: AppState.loading(),
      middleware: createStoreMiddleware()

    );
    Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      theme: ThemeData(primaryColor: Colors.orange[200]),
      routes: <String, WidgetBuilder>{        
        SIGN_IN: (BuildContext context) =>  SignInPage(),        
      },
      initialRoute: SIGN_IN,
    );
  }

//  Widget build(BuildContext context) {
//       return StoreProvider(
//         store:store,
//         child:MaterialApp(
//           title: "Tammu Roastery",
//           routes: {
//             AppRoute.home:(context){
//               return HomeScreen(
//                 onInit: (){
//                   print("init home : ");
//                    StoreProvider.of<AppState>(context).dispatch(LoadBills());
//                    StoreProvider.of<AppState>(context).dispatch(LoadProductAction());
//                 },
//               );
//             },
//             AppRoute.addProduct: (context) {
//             return AddProductForm();
//             },
//             AppRoute.detailTransaction:(context){
//               return DetailBill(
//                 setUp: (){
                 
//                 },
//               );
//             },
//             AppRoute.addTransaction:(context){
//               return DataTransaction(setUp:(){
//                   StoreProvider.of<AppState>(context).dispatch(LoadProductAction());
//               });
//             }
//           }   
//         ),
//       );
//     }
}
