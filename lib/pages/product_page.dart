import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:khao/pages/product_page_widgets.dart';

class Myapp2 extends StatefulWidget {
  final Product? product;
  const Myapp2({Key? key, this.product}) : super(key: key);

  @override
  State<Myapp2> createState() => _Myapp2State();
  
}

class _Myapp2State extends State<Myapp2> {
  late String pname;
  late String pimage;
  late String pweight;
  late String warn;
  late String nutri_Score;
  late String nova_Score;
  late String Carbs;
  late String Protein;
  late String kyahai;
  late String additives;
  late String aller;
  late String ingri;
  @override
  void initState() {
    super.initState();
    final user = firebase_auth.FirebaseAuth.instance.currentUser;
    final userid=user?.uid;
    print("User ID:$userid");
    pname = widget.product?.productName ?? 'No product found';  
    pimage= widget.product?.imageFrontUrl ?? 'data not found';
    pweight= widget.product?.quantity ?? "data not  availaible";
    warn= "personalized warning";
    nutri_Score= widget.product?.nutriscore ?? 'nutriscore not found';
    nova_Score= widget.product?.novaGroup?.toString() ??"nova score not found";
    Carbs= widget.product?.nutriments?.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams).toString() ??"not found";
    Protein= widget.product?.nutriments?.getValue(Nutrient.proteins, PerSize.oneHundredGrams).toString() ??"not found";
    kyahai= 'vegan';
    additives= widget.product?.additives?.names.join(', ') ?? "not found";
    aller= widget.product?.allergens?.names.join(',') ??'allegens not found';
    ingri= widget.product?.ingredientsText ??'No ingredients available';



  final data = widget.product;
  String prod_barcode = data?.barcode ?? ' ';
  String prod_name = data?.productName ?? ' ';
  String prod_url = data?.imageFrontUrl ?? ' ';
  String prod_weight = data?.quantity ?? ' ';
  String prod_warning ="personalized warning"; // Placeholder for personalized warning
  String nutriscore = data?.nutriscore ?? 'Nutri-Score not found';
  String novascore = data?.novaGroup?.toString() ?? 'NOVA Score not found';
  String ecoscore = data?.ecoscoreGrade.toString() ?? 'Ecoscore Not found';
  String vegan_status;
  String veg_status;
  String non_veg_status;

  bool status_checker1 = isVegan(data);
  if (status_checker1) {
    vegan_status = 'yes';
    veg_status = 'yes';
    non_veg_status = 'no';
  } else if (isVegetarian(data)) {
    vegan_status = 'no';
    veg_status = 'yes';
    non_veg_status = 'no';
  } else {
    vegan_status = 'no';
    veg_status = 'no';
    non_veg_status = 'yes';
  }

  String? protein_100gms =data?.nutriments?.getValue(Nutrient.proteins, PerSize.oneHundredGrams).toString() ??"0.0";
  String? carbs_100gms = data?.nutriments?.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams).toString() ??"0.0";
  String? fats_100gms =data?.nutriments?.getValue(Nutrient.fat, PerSize.oneHundredGrams).toString() ?? "0.0";
  String? added_sugar_100gms = data?.nutriments?.getValue(Nutrient.addedSugars, PerSize.oneHundredGrams).toString() ??"0.0";
  String? sugar_100gms =data?.nutriments?.getValue(Nutrient.sugars, PerSize.oneHundredGrams).toString() ?? "0.0";
  String additives_01 =data?.additives?.names.toString() ?? 'Additives not found';
  Allergens? allergen_01 = data?.allergens;
  String? allergens_str = allergen_01?.names.join(',') ?? 'Allergens not found';
  List<Ingredient>? ingredients = data?.ingredients;
  String ingredients_str = data?.ingredientsText?.toString() ?? ' ';
  
  //Printing All Things
  print('Product Barcode: $prod_barcode');
  print('Product Name: $prod_name');
  print('Product URL: $prod_url');
  print('Product Weight: $prod_weight');
  print('Product Warning: $prod_warning');
  print('Nutri-Score: $nutriscore');
  print('NOVA Score: $novascore');
  print('Eco-Score: $ecoscore');
  print('Protein per 100g: $protein_100gms');
  print('Carbohydrates per 100g: $carbs_100gms');
  print('Fats per 100g: $fats_100gms');
  print('Added Sugar per 100g: $added_sugar_100gms');
  print('Total Sugar per 100g: $sugar_100gms');
  print('Additives: $additives_01');
  print('Allergens: $allergens_str');
  print('Ingredients: $ingredients_str');
  print('vegan: $vegan_status');
  print('veg: $veg_status');
  print('non veg: $non_veg_status');


//Inserting Product Details to Database For Search History
  try {
    CollectionReference colref = FirebaseFirestore.instance.collection('Khao').doc(userid).collection('scan_product');
    colref.add({
      'scan_timestamp':Timestamp.now(),
      'scan_id':2,
      'prod_barcode':prod_barcode,
      'prod_name':prod_name,
      'prod_url':prod_url,
      'prod_weight':prod_weight,
      'prod_warning':prod_warning,			
      'nutriscore':nutriscore,
      'novascore':novascore,
      'ecoscore':ecoscore,
      'protein_100gms':protein_100gms.toString(),
      'carbs_100gms':carbs_100gms.toString(),
      'fats_100gms':fats_100gms.toString(),
      'added_sugar_100gms':added_sugar_100gms.toString(),
      'sugar_100gms':sugar_100gms.toString(),
      'additives':additives_01,
      'allergens':allergens_str,
      'ingredients':ingredients_str,
      'vegan_status':vegan_status,
      'vegetarian_status':veg_status,
      'nonvegetarian_status':non_veg_status,
});
  print('Product added to Firestore successfully!');
}
 catch (e) {
  print('Error adding product to Firestore: $e');
}
// Fetch();
}


//Fetching Product Details From FIrebase
Future<void> Fetch() async{
// try {
//   final user = firebase_auth.FirebaseAuth.instance.currentUser;
//   final userid=user?.uid;
//   print("User ID:$userid");
//   CollectionReference colref = FirebaseFirestore.instance.collection('Khao').doc(userid).collection('scan_product');
  
//   // Get documents from the collection
//   QuerySnapshot<Object?> querySnapshot = await colref.get();

//   // Loop through the documents and extract data
//   querySnapshot.docs.forEach((doc) {
//     // Access data using doc.data()
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     // Access specific fields
//     String productName = data['name'];
//     print("fetchingfetching");
//  print(data);
//   });

// } catch (e) {
//   print('Error fetching data from Firestore: $e');
// }
try {
  final user = firebase_auth.FirebaseAuth.instance.currentUser;
  final userid = user?.uid;
  print("User ID: $userid");
  CollectionReference colref = FirebaseFirestore.instance.collection('Khao').doc(userid).collection('scan_product');
  
  // Get documents from the collection
  QuerySnapshot<Object?> querySnapshot = await colref.get();

  // Loop through the documents and extract data
  querySnapshot.docs.forEach((doc) {
    // Access data using doc.data()
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    // Perform null check before accessing fields
    if (data != null) {
      print("Fetching data: $data");
    }
  });
} catch (e) {
  print('Error fetching data from Firestore: $e');
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
          child: Column(
            children: [
              Pinfo(
                  pname: pname,
                  pimage: pimage,
                  pweight: pweight),
              Warning(warn: warn),
              Scores(
                  nutri_Score: nutri_Score,
                  nova_Score: nova_Score),
              Nutrition_panel(
                nutrition_data: {
                  "Carbs per 100gms": Carbs,
                  "Protein per 100gms": Protein,
                },
              ),
              J_veg_nveg_vegan(kyahai: kyahai),
              Additives(
                  additives: widget.product?.additives?.names ?? ["not found"]),
              Allergents(
                  aller: aller),
              Ingridients(
                  ingri: ingri
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




bool isVegan(Product? product) {
  // Get the vegan_status attribute from the product
  String? veganStatus = product?.ingredientsAnalysisTags?.veganStatus?.offTag
      .replaceAll('en:', '');

  // Check if veganStatus is not null and is equal to 'yes' or 'true'
  if (veganStatus != null &&
      (veganStatus.toLowerCase() == 'yes' ||
          veganStatus.toLowerCase() == 'true')) {
    // The product is vegan
    return true;
  } else {
    // The product is not vegan
    return false;
  }
}

bool isVegetarian(Product? product) {
  // Get the vegetarian_status attribute from the product
  String? vegetarianStatus = product
      ?.ingredientsAnalysisTags?.vegetarianStatus?.offTag
      .replaceAll('en:', '');

  // Check if vegetarianStatus is not null and is equal to 'yes' or 'true'
  if (vegetarianStatus != null &&
      (vegetarianStatus.toLowerCase() == 'yes' ||
          vegetarianStatus.toLowerCase() == 'true')) {
    // The product is vegetarian
    return true;
  } else {
    // The product is not vegetarian
    return false;
  }
}


