//This code is no longer being used seekhne ke liye dekhna hai toh theek hai warna yeh kuch kaam ka nai hai
//replaces by the code natively added in the












// import 'dart:async';
// import 'package:openfoodfacts/openfoodfacts.dart';

// Future<void> getProduct(String barcode) async {
//   OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'Khao');

//   OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[
//     OpenFoodFactsLanguage.ENGLISH
//   ];

//   OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.INDIA;
//   try {
//     final configuration = ProductQueryConfiguration(
//       barcode,
//       language: OpenFoodFactsLanguage.ENGLISH,
//       version: ProductQueryVersion.v3,
//     );
//     final result = await OpenFoodAPIClient.getProductV3(configuration);
//   } catch (error) {
//     print('$error');
//   }
// }
