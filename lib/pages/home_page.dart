import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khao/pages/product_page.dart';
import 'package:khao/pages/signup.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:khao/pages/scanner.dart'; // Import the Scanner class
import 'package:firebase_auth/firebase_auth.dart'as firebase_auth;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  TextEditingController _searchController = TextEditingController();
  List<Product>? _searchResults;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Khao the app'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchProducts(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _searchResults != null
                    ? ListView.builder(
                        itemCount: _searchResults!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_searchResults![index].productName ??
                                'Unknown'),
                            subtitle: Text(_searchResults![index].brands ?? ''),
                            leading: _searchResults![index].imageFrontUrl !=
                                    null
                                ? Image.network(
                                    _searchResults![index].imageFrontUrl ?? '',
                                    width: 50, // Adjust the width as needed
                                    height: 50, // Adjust the height as needed
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(
                                    width: 50, // Adjust the width as needed
                                    height: 50, // Adjust the height as needed
                                    child:
                                        Placeholder(), // Placeholder if no image available
                                  ),
                            onTap: () {
                              // Handle tap on search result
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Myapp2(
                                    product: _searchResults![index],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : Center(
                      child: Column(
                        children: [
                          Text('Welcome to Khao'),
                          ElevatedButton(
                    onPressed: () {
                      // Add your button press logic here
                      firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;
                      print("userrrrrr::::::::::::::::::::::::::::::::::::::");
                      print(user);
                      // Extract the user's display name
                      String displayName = user?.displayName ?? "Unknown User";
                      print(displayName);
                    },
                    child: Text('Details'),
                  ),
                  ElevatedButton(
                    onPressed: _SignOut,
                    child: Text('signout'),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, '/upload');
                    },
                    child: Text('upload'),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, '/history');
                    },
                    child: Text('history'),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, '/user_profile');
                    },
                    child: Text('user_profile'),
                  ),
                ],
                )
       ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          await Scanner.scanBarcode(Navigator.of(context));
          setState(() {
            _isLoading = false;
          });
        },
        child: Icon(Icons.qr_code_scanner),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Future<void> _searchProducts(String searchTerm) async {
    setState(() {
      _isLoading = true;
    });

    final configuration = ProductSearchQueryConfiguration(
      parametersList: <Parameter>[
        SearchTerms(terms: [searchTerm]),
      ],
      languages: OpenFoodAPIConfiguration.globalLanguages,
      version: ProductQueryVersion.v3,
    );

    try {
      final result = await OpenFoodAPIClient.searchProducts(
        null, // Pass null for the user parameter if not using authentication
        configuration,
      );

      if (result.products != null) {
        setState(() {
          _searchResults = result.products;
          _isLoading = false; // Hide loading indicator
        });
      } else {
        print('No products found.');
      }
    } catch (e) {
      print('Error searching products: $e');
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator even if there's an error
      });
    }
  }

final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _SignOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
      SignUpState.isSignedUp = false;
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
