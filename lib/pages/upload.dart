import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';

// import 'package:openfoodfacts/model/Nutriments.dart';
// import 'package:openfoodfacts/model/Product.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
// import 'package:openfoodfacts/model/Product.dart';


class ProductUploader extends StatefulWidget {
  @override
  _ProductUploaderState createState() => _ProductUploaderState();
}

User currentUser = User(userId: "khaa", password: "Khao@23");


class _ProductUploaderState extends State<ProductUploader> {
  TextEditingController nameController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController nutritionController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();
  TextEditingController categoryController= TextEditingController();
  File? _image;
  File? _image2;
  File? _image3;
  File? _image4;

  // Variables to store input values
  String productName = '';
  String company = '';
  String weight = '';
  String ingredients = '';
  String barcode='';
  String category='';
  // Variables to store nutrient values
  String energy = '';
  String fat = '';
  String saturatedFat = '';
  String carbohydrates = '';
  String sugar = '';
  String fiber = '';
  String proteins = '';
  String salt = '';

 // Function to handle the submission of the product
  
// Function to handle the submission of the product
  Future<void> submitProduct() async {

    print('Product Name: $productName');
    print('Barcode: $barcode');
    print('Category:,$category');
    print('Company: $company');
    print('Weight: $weight');
    print('Ingredients: $ingredients');
    print('Energy: $energy');
    print('Fat: $fat');
    print('Saturated Fat: $saturatedFat');
    print('Carbohydrates: $carbohydrates');
    print('Sugar: $sugar');
    print('Fiber: $fiber');
    print('Proteins: $proteins');
    print('Salt: $salt');

    // Validate if all required fields are filled
    if (productName.isEmpty ||
        company.isEmpty ||
        weight.isEmpty ||
        ingredients.isEmpty ||
        energy.isEmpty ||
        fat.isEmpty ||
        saturatedFat.isEmpty ||
        carbohydrates.isEmpty ||
        sugar.isEmpty ||
        fiber.isEmpty ||
        proteins.isEmpty ||
        salt.isEmpty ||
        _image == null ||
        _image2 == null ||
        _image3 == null ||
        _image4 == null) {
      // Show an error message if any field is missing
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields and select all images!'),
        ),
      );
      return;
    }

    // Perform further actions like uploading data to Open Food Facts using API
    // Construct the URL for the Open Food Facts API
    String apiUrl = 'https://world.openfoodfacts.org/cgi/product_jqm2.pl';

    // Create multipart request
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    // Add product details as fields
    request.fields['product_name'] = productName;
    request.fields['code'] = barcode;
    request.fields['categories'] = category;
    request.fields['brands'] = company;
    request.fields['quantity'] = weight;
    request.fields['ingredients_text'] = ingredients;
    request.fields['nutriments_energy-kcal_100g'] = energy;
    request.fields['nutriments_fat_100g'] = fat;
    request.fields['nutriments_saturated-fat_100g'] = saturatedFat;
    request.fields['nutriments_carbohydrates_100g'] = carbohydrates;
    request.fields['nutriments_sugars_100g'] = sugar;
    request.fields['nutriscore_2021_category_available_data_fiber'] = fiber;
    request.fields['nutriments_proteins_100g'] = proteins;
    request.fields['nutriments_salt_100g'] = salt;

  request.fields['nutriments_energy-kcal_unit'] = "kcal";
  request.fields['nutriments_fat_unit'] = "g";
  request.fields['nutriments_saturated-fat_unit'] = "g";
  request.fields['nutriments_carbohydrates_unit'] = "g";
  request.fields['nutriments_sugars_unit'] = "g";
  request.fields['nutriments_proteins_unit'] = "g";
  request.fields['nutriments_salt_unit'] = "g";


    // Add image files
    request.files.add(await http.MultipartFile.fromPath('selected_images_front_display_en', _image!.path));
    request.files.add(await http.MultipartFile.fromPath('selected_images.ingredients_front_display_en', _image2!.path));
    request.files.add(await http.MultipartFile.fromPath('selected_images_nutrition_front_display_en', _image3!.path));
    request.files.add(await http.MultipartFile.fromPath('selected_images_packaging_front_display_en', _image4!.path));

    // Send the request
    var response = await request.send();

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Product uploaded successfully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product uploaded successfully!'),
        ),
      );
    } else {
      // Product upload failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload product!'),
        ),
      );
    }
  }






  // Function to handle image selection
  Future getImage() async {
    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('Camera'),
                  onTap: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (imageSource != null) {
      final pickedFile = await ImagePicker().getImage(source: imageSource);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }
  }


Future getImage2() async {
  final imageSource = await showDialog<ImageSource>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Image Source'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Camera'),
                onTap: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      );
    },
  );

  if (imageSource != null) {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    setState(() {
      if (pickedFile != null) {
        _image2 = File(pickedFile.path); // Update _image2
      } else {
        print('No image selected.');
      }
    });
  }
}

// Repeat the same pattern for getImage3 and getImage4






Future getImage3() async {
  final imageSource = await showDialog<ImageSource>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Image Source'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Camera'),
                onTap: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      );
    },
  );

  if (imageSource != null) {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    setState(() {
      if (pickedFile != null) {
        _image3 = File(pickedFile.path); // Update _image3
      } else {
        print('No image selected.');
      }
    });
  }
}

// Repeat the same pattern for getImage3 and getImage4







  Future getImage4() async {
  final imageSource = await showDialog<ImageSource>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Image Source'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Camera'),
                onTap: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      );
    },
  );

  if (imageSource != null) {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    setState(() {
      if (pickedFile != null) {
        _image4 = File(pickedFile.path); // Update _image2
      } else {
        print('No image selected.');
      }
    });
  }
}

// Repeat the same pattern for getImage3 and getImage4



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Product'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Photo',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            _image == null
                ? ElevatedButton(
                    onPressed: getImage,
                    child: Text('Select Image', style: TextStyle(color: Color(0xFF303841))),
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF6C90E)),
                  )
                : SizedBox(
                    height: 200.0,
                    child: _image != null ? Image.file(_image!) : Container(),
                  ),
            SizedBox(height: 20.0),
            Text(
              'Photo 2',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            _image2 == null
                ? ElevatedButton(
                  onPressed: getImage2,
                    child: Text('Select Image', style: TextStyle(color: Color(0xFF303841))),
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF6C90E)),
                  ):
                  SizedBox(
                  height: 200.0,
                  child: _image2 != null ? Image.file(_image2!) : Container(),
                  ),

            SizedBox(height: 20.0),
            Text(
              'Photo 3',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            _image3 == null
                ? ElevatedButton(
                    onPressed: getImage3,
                    child: Text('Select Image', style: TextStyle(color: Color(0xFF303841))),
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF6C90E)),
                  )
                : SizedBox(
                    height: 200.0,
                    child: _image3 != null ? Image.file(_image3!) : Container(),
                  ),
            SizedBox(height: 20.0),
            Text(
              'Photo 4',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            _image4 == null
                ? ElevatedButton(
                    onPressed: getImage4,
                    child: Text('Select Image', style: TextStyle(color: Color(0xFF303841))),
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF6C90E)),
                  )
                : SizedBox(
                    height: 200.0,
                    child: _image4 != null ? Image.file(_image4!) : Container(),
                  ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: nameController,
              onChanged: (value) {
                setState(() {
                  productName = value; // Update productName variable
                });
              },
              decoration: InputDecoration(
                labelText: 'Product Name',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF6C90E)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: barcodeController,
              onChanged: (value) {
                setState(() {
                  barcode = value; // Update productName variable
                });
              },
              decoration: InputDecoration(
                labelText: 'Product Barcode',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF6C90E)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: companyController,
              onChanged: (value) {
                setState(() {
                  company = value; // Update company variable
                });
              },
              decoration: InputDecoration(
                labelText: 'Company',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF6C90E)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: categoryController,
              onChanged: (value) {
                setState(() {
                  category = value; // Update company variable
                });
              },
              decoration: InputDecoration(
                labelText: 'Category',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF6C90E)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: weightController,
              onChanged: (value) {
                setState(() {
                  weight = value; // Update weight variable
                });
              },
              decoration: InputDecoration(
                labelText: 'Weight',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF6C90E)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: ingredientsController,
              onChanged: (value) {
                setState(() {
                  ingredients = value; // Update ingredients variable
                });
              },
              decoration: InputDecoration(
                labelText: 'Ingredients',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF6C90E)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // Nutrition Table Placeholder
            Text(
              'Nutrition Table Placeholder',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Table(
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Nutrients',
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Units',
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            energy = value; // Update energy variable
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Energy',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF6C90E)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF3A4750),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'kj',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            fat = value; // Update fat variable
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Fat',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF6C90E)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),                            
                            decoration: BoxDecoration(
                              color: Color(0xFF3A4750),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'g',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            saturatedFat = value; // Update saturatedFat variable
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Saturated Fat',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF6C90E)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),                            
                            decoration: BoxDecoration(
                              color: Color(0xFF3A4750),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'g',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            carbohydrates = value; // Update carbohydrates variable
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Carbohydrates',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF6C90E)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),                            
                            decoration: BoxDecoration(
                              color: Color(0xFF3A4750),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'g',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            sugar = value; // Update sugar variable
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Sugar',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF6C90E)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),                            
                            decoration: BoxDecoration(
                              color: Color(0xFF3A4750),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'g',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            fiber = value; // Update fiber variable
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Fiber',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF6C90E)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),                            
                            decoration: BoxDecoration(
                              color: Color(0xFF3A4750),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'g',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            proteins = value; // Update proteins variable
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Proteins',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF6C90E)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),                            
                            decoration: BoxDecoration(
                              color: Color(0xFF3A4750),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'g',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            salt = value; // Update salt variable
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Salt',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF6C90E)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),                            
                            decoration: BoxDecoration(
                              color: Color(0xFF3A4750),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'g',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: submitProduct,
              child: Text('Submit', style: TextStyle(color: Color(0xFF303841))),
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF6C90E)),
            ),
          ],
        ),
      ),
    );
  }
}
