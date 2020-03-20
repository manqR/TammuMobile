import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myapp/actions/action.dart';
import 'package:myapp/models/app_route.dart';
import 'package:myapp/reducers/app_reducer.dart';
import 'package:myapp/middleware/app_middleware.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

import 'package:myapp/presentation/detail_bill.dart';
import 'package:myapp/presentation/form_product.dart';
import 'package:myapp/presentation/form_transaction.dart';
import 'package:myapp/presentation/home_screen.dart';

import 'package:myapp/constants/constants.dart';
import 'package:myapp/widgets/custom_shape.dart';
import 'package:myapp/widgets/responsive_ui.dart';
import 'package:myapp/widgets/textformfield.dart';




class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();



  @override
  Widget build(BuildContext context) {
     _height = MediaQuery.of(context).size.height;
     _width = MediaQuery.of(context).size.width;
     _pixelRatio = MediaQuery.of(context).devicePixelRatio;
     _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
     _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      child: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              welcomeTextRow(),
              signInTextRow(),
              form(),
              SizedBox(height: _height / 12),
              button(),              
            ],
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height:_large? _height/4 : (_medium? _height/3.75 : _height/3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large? _height/4.5 : (_medium? _height/4.25 : _height/4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(top: _large? _height/30 : (_medium? _height/25 : _height/20)),
          child: Image.asset(
            'assets/images/login.png',
            height: _height/3.5,
            width: _width/3.5,
          ),
        ),
      ],
    );
  }

  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        children: <Widget>[
          Text(
            "Tammu",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _large? 60 : (_medium? 50 : 40),              
            ),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Roastery POS",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: _large? 20 : (_medium? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0,
          right: _width / 12.0,
          top: _height / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            inputTextFormField(),
            SizedBox(height: _height / 40.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget inputTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: usernameController,
      icon: Icons.email,
      hint: "Username",
    );

  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: passwordController,
      icon: Icons.lock,
      obscureText: true,
      hint: "Password",
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {

         Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          // return StoreProvider(
          //   store:store,
          //   child:MaterialApp(
          //     title: "Tammu Roastery",
          //     routes: {
          //       AppRoute.home:(context){
          //         return HomeScreen(
          //           onInit: (){
          //             print("init home : ");
          //             StoreProvider.of<AppState>(context).dispatch(LoadBills());
          //             StoreProvider.of<AppState>(context).dispatch(LoadProductAction());
          //           },
          //         );
          //       },
          //       AppRoute.addProduct: (context) {
          //       return AddProductForm();
          //       },
          //       AppRoute.detailTransaction:(context){
          //         return DetailBill(
          //           setUp: (){
                    
          //           },
          //         );
          //       },
          //       AppRoute.addTransaction:(context){
          //         return DataTransaction(setUp:(){
          //             StoreProvider.of<AppState>(context).dispatch(LoadProductAction());
          //         });
          //       }
          //     }   
          //   ),
          // );
          // print("Routing to your account");
          // Scaffold
          //     .of(context)
          //     .showSnackBar(SnackBar(content: Text('Login Successful')));

      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: _large? _width/4 : (_medium? _width/3.75: _width/3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.orange[200], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('SIGN IN',style: TextStyle(fontSize: _large? 14: (_medium? 12: 10))),
      ),
    );
  }

}

class HomePage extends StatelessWidget {
  
    final store = Store<AppState>(
      appReducer,
      initialState: AppState.loading(),
      middleware: createStoreMiddleware()

    );

 Widget build(BuildContext context) {
      return StoreProvider(
        store:store,
        child:MaterialApp(
          title: "Tammu Roastery",
          routes: {
            AppRoute.home:(context){
              return HomeScreen(
                onInit: (){
                  print("init home : ");
                   
                   StoreProvider.of<AppState>(context).dispatch(LoadProductAction());
                },
              );
            },
            AppRoute.addProduct: (context) {
            return AddProductForm();
            },
            AppRoute.detailTransaction:(context){
              return DetailBill(
                setUp: (){
                 
                },
              );
            },
            AppRoute.addTransaction:(context){
              return DataTransaction(setUp:(){
                  StoreProvider.of<AppState>(context).dispatch(LoadProductAction());
              });
            }
          }   
        ),
      );
    }

    
}
