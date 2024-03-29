import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 220, 220),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 229, 220, 220),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          color: const Color.fromARGB(255, 136, 192, 72),
          tooltip: 'Back',
          iconSize: 35.0,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.account_circle_rounded),
            color: const Color.fromARGB(255, 136, 192, 72),
            iconSize: 35.0,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<void>(
          future: Fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is being fetched, show a loading indicator
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // If an error occurs during data fetching, display an error message
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // If data is successfully fetched, display the Product_row widgets
              return Column(
                children: snapshot.data as List<Widget>,
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Widget>> Fetch() async {
    try {
      final user = firebase_auth.FirebaseAuth.instance.currentUser;
      final userid = user?.uid;
      print("User ID: $userid");
      CollectionReference colref = FirebaseFirestore.instance
          .collection('Khao')
          .doc(userid)
          .collection('scan_product');

      // Get documents from the collection
      QuerySnapshot<Object?> querySnapshot = await colref.get();

      List<Widget> productRows = [];

      // Loop through the documents and extract data
      querySnapshot.docs.forEach((doc) {
        // Access data using doc.data()
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

        // Perform null check before accessing fields
        if (data != null) {
          print("Fetching data: $data");

          // Create a Product_row widget and add it to the list
          productRows.add(Product_row(
            pname: data['prod_name'],
            pimage: data['prod_url'],
            nutriscore: data['nutriscore'],
            novascore: data['novascore'],
            data: data
          ));
        }
      });

      return productRows;
    } catch (e) {
      print('Error fetching data from Firestore: $e');
      return []; // Return an empty list if an error occurs
    }
  }
}

class Product_row extends StatefulWidget {
  final String pname;
  final String pimage;
  final String nutriscore;
  final String novascore;
  final Map<String, dynamic>? data;
  const Product_row(
      {Key? key,
      required this.pname,
      required this.pimage,
      required this.nutriscore,
      required this.novascore,
      required this.data
      })
      : super(key: key);

  @override
  State<Product_row> createState() => _Product_rowState();
}

class _Product_rowState extends State<Product_row> {
  @override
  late Widget categoryIcon;
  late Widget categoryIcons;
  Widget build(BuildContext context) {
    switch (widget.nutriscore) {
      case 'a':
        categoryIcon = Container(
            width: 75,
            height: 75, 
            child: Image.asset('assets/nutri_a.png'));
        break;

      case 'b':
        categoryIcon = Container(
            width: 75,
            height: 75, 
            child: Image.asset('assets/nutri_b.png'));
        break;

      case 'c':
        categoryIcon = Container(
            width: 75,
            height: 75, 
            child: Image.asset('assets/nutri_c.png'));
        break;

      case 'd':
        categoryIcon = Container(
            width: 75,
            height: 75,
            child: Image.asset('assets/nutri_d.png'));
        break;

      case 'e':
        categoryIcon = Container(
            width: 75,
            height: 75, 
            child: Image.asset('assets/nutri_e.png'));
        break;

      default:
        categoryIcon = Container(
            width: 75,
            height: 75, 
            child: Image.asset('assets/nutri_d.png'));
        break;
    }
    switch (widget.novascore) {
      case '1':
        categoryIcons = Container(
            width: 75,
            height: 60,
            child: SvgPicture.asset('assets/nova_1.svg'));
        break;

      case '2':
        categoryIcons = Container(
            width: 75,
            height: 60,
            child: SvgPicture.asset('assets/nova_2.svg'));
        break;

      case '3':
        categoryIcons = Container(
            width: 75,
            height: 60,
            child: SvgPicture.asset('assets/nova_3.svg'));
        break;

      case '4':
        categoryIcons = Container(
            width: 75,
            height: 60,
            child: SvgPicture.asset('assets/nova_4.svg'));
        break;

      default:
        categoryIcons = Container(
            width: 75,
            height: 60,
            child: SvgPicture.asset('assets/nova_4.svg'));
        break;
    }
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacementNamed(context, '/product_history', arguments: widget.data);
      },
      child: Container(
        
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.network(
              widget.pimage,
              width: 150,
              height: 150,
            ),
            SizedBox(width: 10), // Add spacing between image and text
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.pname,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      categoryIcon,
                      categoryIcons,
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
