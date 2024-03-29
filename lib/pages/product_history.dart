import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:khao/pages/product_page_widgets.dart';

class Myhistory extends StatefulWidget {
  final Map<String, dynamic>? data;
  const Myhistory({Key? key, this.data}) : super(key: key);

  @override
  State<Myhistory> createState() => _MyhistoryState();
  
}

class _MyhistoryState extends State<Myhistory> {
  late List<String> additivesList;
  void initState(){
  super.initState();
  String? additivesString = widget.data?['additives'] ?? '';
  // Ensure additivesString is not null and not empty
  if (additivesString != null && additivesString.isNotEmpty) {
    additivesList = additivesString.split(',').map((additive) => additive.trim()).toList();
  } else {
    // If additivesString is null or empty, initialize additivesList as an empty list
    additivesList = [];
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 229, 220, 220),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 229, 220, 220),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/history');
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
          child: Column(
            children: [
              Pinfo(
                  pname: widget.data?['prod_name'],
                  pimage: widget.data?['prod_url'],
                  pweight: widget.data?['prod_weight']),
              Warning(warn: widget.data?['prod_warning']),
              Scores(
                  nutri_Score: widget.data?['nutriscore'],
                  nova_Score: widget.data?['novascore']),
              Nutrition_panel(
                nutrition_data: {
                  "Carbs per 100gms":widget.data?['carbs_100gms'].toString() ??"not",
                  "Protein per 100gms":widget.data?['protein_100gms'].toString() ??"not",
                },
              ),
              J_veg_nveg_vegan(kyahai: 'vegan'),
              Additives(
                  additives: additivesList),
              Allergents(
                  aller: widget.data?['allergens']),
              Ingridients(
                  ingri: widget.data?['ingredients']
                  ),
            ],
          ),
        ));
  }
}

class Additives extends StatefulWidget {
  final List<String> additives;
  const Additives({Key? key, required this.additives}) : super(key: key);
  @override
  State<Additives> createState() => _AdditivesState();
}

class _AdditivesState extends State<Additives> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      constraints:
          BoxConstraints(minWidth: MediaQuery.of(context).size.width - 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Additives',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: widget.additives.map((additive) {
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 207, 102, 137),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      additive,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList())
          ]),
        ],
      ),
    );
  }
}

