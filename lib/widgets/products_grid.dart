// import 'package:flutter/material.dart';

// class ProductsGrid extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       padding: EdgeInsets.all(10),
//       itemBuilder: (context, index) {
//         return ProductItem(
//           id: loadedProducts[index].id,
//           name: loadedProducts[index].name,
//           imageURL: loadedProducts[index].imageURL,
//         );
//       },
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         childAspectRatio: 3 / 2,
//         crossAxisCount: 2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemCount: loadedProducts.length,
//     );
//   }
// }
