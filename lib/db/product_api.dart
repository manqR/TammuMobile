import 'package:myapp/models/product.dart';
import 'package:myapp/db/db_helper.dart';
import 'package:dio/dio.dart';


class ProductApiProvider {
  Future<List<Product>> getAllProduct() async {
    var accessKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImRlbW8yIiwiaWF0IjoxNTgyMDIwMjAxLCJleHAiOjE1ODIxMDY2MDF9.SYWOD0pQfGknOo6E053vSyf2iktmWua854owwkzSqMs";
    var url = "http://10.1.7.108:3000/api/auth/product?x-access-token="+accessKey+"";
    Response response = await Dio().get(url);

    return (response.data as List).map((product) {
      print('Inserting $product');
      DbHelper.db.createProduct(Product.fromJson(product));
    }).toList();
  }
}

// class ProductApi {
  
//   Future<List<Product>> getAllEmployees() async {
//     var accessKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImRlbW8yIiwiaWF0IjoxNTgyMDIwMjAxLCJleHAiOjE1ODIxMDY2MDF9.SYWOD0pQfGknOo6E053vSyf2iktmWua854owwkzSqMs";
//     var url = "http://10.1.7.108:3000/api/auth/product?x-access-token="+accessKey+"";
//     Response response = await Dio().get(url);

//     return (response.data as List).map((employee) {
//       print('Inserting $Product');
//       DbHelper.db.createProduct(Product().(Product));
//     }).toList();
//   }
// }


// import 'package:api_to_sqlite_flutter/src/models/employee_model.dart';
// import 'package:api_to_sqlite_flutter/src/providers/db_provider.dart';
// import 'package:dio/dio.dart';

// class EmployeeApiProvider {
//   Future<List<Employee>> getAllEmployees() async {
//     var url = "http://demo8161595.mockable.io/employee";
//     Response response = await Dio().get(url);

//     return (response.data as List).map((employee) {
//       print('Inserting $employee');
//       DBProvider.db.createEmployee(Employee.fromJson(employee));
//     }).toList();
//   }
// }