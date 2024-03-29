import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:barcode_scan2/barcode_scan2.dart' as scan;

class Scanner extends StatelessWidget {
  static bool _isUserAgentSet = false;

  @override
  Widget build(BuildContext context) {
    return Container(); // Replace this with your scanner UI
  }

  static Future<void> scanBarcode(NavigatorState navigator) async {
    try {
      // Set user agent when the page is initialized
      await _setUserAgent();

      // Ensure user agent is set before scanning
      if (!_isUserAgentSet) {
        print('User agent is not set');
        return;
      }

      // Perform barcode scanning
      scan.ScanResult scanResult = await scan.BarcodeScanner.scan();
      String barcode = scanResult.rawContent;

      // Query product information using OpenFoodFacts API
      final configuration = ProductQueryConfiguration(
        barcode,
        language: OpenFoodFactsLanguage.ENGLISH,
        version: ProductQueryVersion.v3,
      );

      final result = await OpenFoodAPIClient.getProductV3(configuration);
      if (result != null && result.product != null) {
        // Navigate to the product page
        navigator.pushReplacementNamed('/product', arguments: result.product);
        
      } else {
        navigator.pushReplacementNamed('/upload');
        // Handle case where product information is not found
        ScaffoldMessenger.of(navigator.context).showSnackBar(
          SnackBar(content: Text('Product information not found')),
        );
      }
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(navigator.context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  static Future<void> _setUserAgent() async {
    try {
      // Set user agent
      OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'Khao');
      // Set global languages
      OpenFoodAPIConfiguration.globalLanguages = [
        OpenFoodFactsLanguage.ENGLISH
      ];
      // Set flag to true once user agent is set
      _isUserAgentSet = true;
    } catch (e) {
      // Handle error if user agent cannot be set
      print('Error setting user agent: $e');
    }
  }
}
