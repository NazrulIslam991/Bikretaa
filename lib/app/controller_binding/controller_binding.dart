// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
//
// import '../../app/controller/customer_controller/customer_controller.dart';
// import '../../app/controller/product_controller/product_controller.dart';
// import '../../app/controller/sales_controller/sales_controller.dart';
//
// class AppBindings extends Bindings {
//   final user = FirebaseAuth.instance.currentUser;
//
//   @override
//   void dependencies() {
//     if (user != null) {
//       Get.put(ProductController(), permanent: true);
//       Get.put(CustomerController(), permanent: true);
//       Get.put(SalesController(), permanent: true);    }
//   }
// }
