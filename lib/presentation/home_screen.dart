
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:myapp/actions/action.dart';
import 'package:myapp/models/app_route.dart';
import 'package:myapp/models/app_state.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/presentation/transaction_view.dart';
import 'package:myapp/presentation/form_transaction.dart';
import 'package:myapp/presentation/form_profile.dart';

class HomeScreen extends StatefulWidget{

  final Function onInit;
  HomeScreen({this.onInit});

  @override
  _HomeScreen createState() => _HomeScreen();


}

class _HomeScreen extends State<HomeScreen>{
 
  final List<Widget> listWidget = [
    TransactionView(),
    Home(),
    Profile()
  ];

  var selectedId = 0;
  var titleButton = "";
 
  @override
    void initState() {
      widget.onInit();
      super.initState();
    }

 @override
  Widget build(BuildContext context) {
     print(listWidget);
  
    return Scaffold(
      appBar: AppBar(
        title: Text("Tammu Roastery"),
      ),
      body: Scaffold(
        body : listWidget[selectedId],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedId,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              title: Text("Transaction")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_drink),
              title: Text('Product')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
            ),
          ],
          onTap: (index){
              setState(() {
                selectedId = index;
                print(selectedId);
                // if(index == 0)
                //   titleButton = "Add Transaction";
                // else
                //   titleButton = "Add Products";
                  
              });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
         floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          child: Icon(Icons.add),        
          onPressed: (){        
            if(selectedId == 0){
              //Navigator.pushNamed(context, AppRoute.addTransaction);
               Navigator.push(context,MaterialPageRoute(builder: (context) => DataTransaction(setUp: (){
                            StoreProvider.of<AppState>(context).dispatch(LoadProductAction());
                          },
                  )
                ));
            }else
              Navigator.pushNamed(context, AppRoute.addProduct);
          },
        ),
      ),
      
    );
  }

}


class Home extends StatefulWidget{
  Home({Key key}) : super(key: key);
  @override
  _Home createState() => _Home();

}

class _Home extends State<Home>{

    @override
      void initState() {
        super.initState();
      }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
            converter: _ViewModel.fromStore,
            builder: (context, vm){
              return ListView.builder(
              itemCount: vm.products.length,
              itemBuilder: (BuildContext context, int index){
              
                final product = vm.products[index];
                return ItemList(
                  product: product,
                );
              },
              );
            }
          );
    }

  }


  class _ViewModel{
    final List<Product> products;
    final Product product;
    final bool isLoading;
  _ViewModel({
    @required this.isLoading,
    @required this.products,
    @required this.product
    });
    
    static _ViewModel fromStore(Store<AppState> store){
      //print("list store : "+store.state.products.length.toString());
      store.state.products.forEach((product) {
        print("product : "+product.id.toString()+" name : "+product.name);
      });

      return _ViewModel(
        isLoading: store.state.isLoading,
        products: store.state.products,
        product: store.state.product
      );
    }
  }

  class ItemList extends StatelessWidget{
  final Product product;
  ItemList({this.product});

  @override
  Widget build(BuildContext context) {
    
    return Container(
          margin: new EdgeInsets.only(top: 8.0, left:16.0, right:16.0, bottom:8.0) ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(product.name, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              Text("Rp. "+product.price.toString()),
              Text("Qty : "+product.qty.toString()),
            ],
          )
        
        );
  }

  }

