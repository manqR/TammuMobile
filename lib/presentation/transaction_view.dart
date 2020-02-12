
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:myapp/actions/action.dart';
import 'package:myapp/presentation/detail_bill.dart';
import 'package:myapp/models/bill.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myapp/models/app_state.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';

class TransactionView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _TransactionState();

}


class _TransactionState extends State<TransactionView>{


  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, ViewModel>(
            converter: ViewModel.fromStore,
            builder: (context, vm){
              // print("list all bills "+vm.bills.length.toString());
              return RefreshIndicator(
              
                onRefresh: _handleRefresh,
                child: ListView.builder(
                  itemCount: vm.bills != null ? vm.bills.length : 0,
                  itemBuilder: (BuildContext context, int index){
                    final bill = vm.bills[index];
                    print('klik');
                    return GestureDetector(
                      onTap: (){
                          print("detail : "+bill.id.toString());
                          StoreProvider.of<AppState>(context).dispatch(InsertedIdBill(bill.id));
                          Navigator.push(context,MaterialPageRoute(builder: (context) => DetailBill(setUp: (){
                            StoreProvider.of<AppState>(context).dispatch(GetDetailTranscationAction(idBill:bill.id));
                          },)
                          ));

                      },
                      child: ItemList(
                        bill: bill,
                      ),
                    );
                    
                  },
                  ),
              );
              
              
            }
          );
  }

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 2));
    var action = LoadBills();
    StoreProvider.of<AppState>(context).dispatch(action);
  
    return null;
  }

}

class ViewModel{
  final List<Bill> bills;

  ViewModel({this.bills});
  static ViewModel fromStore(Store<AppState> store){
  
    return new ViewModel(bills:store.state.bills);
  }

}

class ItemList extends StatelessWidget{
  final Bill bill;
  ItemList({this.bill});

  @override
  Widget build(BuildContext context) {
  int epoch = bill.date * 1000;
  var now = new DateTime.fromMicrosecondsSinceEpoch(epoch);
  var formatter = new DateFormat('dd-MM-yyy H:m');
  String date = formatter.format(now);
 
        FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
            amount: bill.totalPrice.toDouble()
        );
        return  new Card(
                    child: new Column(
                      children: <Widget>[
                        // new Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
                        
                        
                        new Padding(
                          padding: new EdgeInsets.all(7.0),
                          child: new Row(
                            children: <Widget>[
                            //    new Padding(
                            //    padding: new EdgeInsets.all(2.0),
                            //    child: new Text('INV/'+bill.date.toString()+bill.id.toString(),style: new TextStyle(fontSize: 18.0,)),
                            //  ),
                            //    new Padding(
                            //    padding: new EdgeInsets.all(2.0),
                            //    child: new Text(date),
                            //  ),
                            // Spacer(flex: 1),
                             new Padding(
                               padding: new EdgeInsets.all(0.0),
                               child: new Text('Total : Rp.',style :new TextStyle(fontSize:14.0,fontWeight: FontWeight.bold)),
                               
                             ),
                             new Padding(
                               padding: new EdgeInsets.all(2.0),
                               child: new Text(fmf.output.nonSymbol.toString(),style: new TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),),
                             ),
                               
                             new Padding(
                               padding: new EdgeInsets.all(2.0),
                               child: new Text('Qty:',style: new TextStyle(fontSize:14.0,fontWeight: FontWeight.bold)),
                             ),
                             new Padding(
                               padding: new EdgeInsets.all(2.0),
                               child: new Text(bill.qty.toString(),style: new TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold)),
                             )

                            ],
                          )
                        )

                      ],
                    ),
                  );
  }

  }