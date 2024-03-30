import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoScreen2 extends StatefulWidget {
  @override
  _UserInfoScreen2State createState() => _UserInfoScreen2State();
}

class _UserInfoScreen2State extends State<UserInfoScreen2> {
  String _username = '';
  int _age = 0;
  int _height = 0;
  int _weight = 0;
  String? _selectedGender;
  List<String> _foodTypes = [];
  List<String> _allergens = [];
  List<String> _healthProblems = [];
  bool _isEditing = false;

  final List<String> _foodTypesOptions = ['Non-veg', 'Veg', 'Jain', 'Vegan'];
  final List<String> _allergensOptions = ['Gluten', 'Milk', 'Soybeans'];
  final List<String> _healthProblemsOptions = ['Diabetes', 'Thyroid', 'Pregnancy'];
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];

  // Define TextEditingController for each TextField
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
    _usernameController.text = _username;
    _heightController.text = _height.toString();
    _weightController.text = _weight.toString();
    _ageController.text = _age.toString();
    
  }
 //Fetching User Details From Firebase
  Future <void> _fetchUserInfo() async{
    // Simulated current values fetched from the database
      String db_username='';
      int db_age=0;
      int db_height=0;
      int db_weight=0;
      String db_gender='';
      int db_non_veg=0;
      int db_veg=0;
      int db_vegan=0;
      int db_jain=0;
      int db_gluten=0;
      int db_milk=0;
      int db_soyabeans=0;
      int db_diabetes=0;
      int db_thyroid=0;
      int db_pregnancy=0;
      int db_lactose_intolerant=0;
      List<String> db_foooptions=[];
      List<String> db_allergens=[];
      List<String> db_healthproblems=[];
  
try {
  final user = FirebaseAuth.instance.currentUser;
  final userid = user?.uid;
  print("User ID: $userid");
  CollectionReference colref = FirebaseFirestore.instance.collection('Khao').doc(userid).collection('user_info');
  
  // Get documents from the collection
  QuerySnapshot<Object?> querySnapshot = await colref.get();

  // Loop through the documents and extract data
  querySnapshot.docs.forEach((doc) {
    // Access data using doc.data()
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    print("Doc-ID,$doc.id");
    // Perform null check before accessing fields
    if (data != null) {
      print("Fetching data: $data");
       db_username=data['username'];
       db_age=data['age'];
       db_height=data['height'];
       db_weight=data['weight'];
       db_gender=data['gender'];
       db_non_veg=data['non_veg'];
       db_veg=data['veg'];
       db_vegan=data['vegan'];
       db_jain=data['jain'];
       db_gluten=data['gluten'];
       db_milk=data['milk'];
       db_soyabeans= data['soyabeans'];
       db_diabetes=data['diabetes'];
       db_thyroid=data['thyroid'];
       db_pregnancy=data['pregnancy'];
       db_lactose_intolerant=data['lactose_intolerant'];
       //Food Options
       if(db_non_veg== 1){
        db_foooptions.add('Non-Veg');
       }
       if(db_veg== 1){
        db_foooptions.add('Veg');
       }
       if(db_vegan== 1){
        db_foooptions.add('Vegan');
       }
       if(db_jain== 1){
        db_foooptions.add('Jain');
       }

        //Allergens
        if(db_gluten== 1){
        db_allergens.add('Gluten');
       }
       if(db_milk== 1){
        db_allergens.add('Milk');
       }
       if(db_soyabeans== 1){
        db_allergens.add('Soyabeans');
       }
       

       //Health Problems
        if(db_diabetes== 1){
        db_healthproblems.add('Diabetes');
       }
       if(db_thyroid== 1){
        db_healthproblems.add('Thyroid');
       }
       if(db_pregnancy== 1){
        db_healthproblems.add('Pregnancy');
       }
       
       

      //Printing All Fetched Things
      print('Username:$db_username');
      print('Age: $db_age');
      print('Height: $db_height');
      print('Weight: $db_weight');
      print('Gender: $db_gender');
      print('Non Veg: $db_non_veg');
      print('Veg: $db_veg');
      print('Vegan: $db_vegan');
      print('Jain: $db_jain');
      print('Gluten: $db_gluten');
      print('Milk: $db_milk');
      print('Soyabeans: $db_soyabeans');
      print('Diabetes: $db_diabetes');
      print('Thyroid: $db_thyroid');
      print('Pregnancy: $db_pregnancy');
      print('Lactose Intolerant: $db_lactose_intolerant');


    }

  });
} catch (e) {
  print('Error fetching data from Firestore: $e');
}


    setState(() {
      _username = db_username;
      _age = db_age;
      _height = db_height;
      _weight = db_weight;
      _selectedGender = db_gender;
      _foodTypes = db_foooptions;
      _allergens = db_allergens;
      _healthProblems =db_healthproblems;
    });
}













//Updation Of User Details In Firebase
  Future<void> _submitForm() async {
    // Implement your logic here to handle form submission
    print('Username: $_username');
    print('Height: $_height');
    print('Weight: $_weight');
    print('Age: $_age');
    print('Gender: $_selectedGender');
    print('Food Types: $_foodTypes');
    print('Allergens: $_allergens');
    print('Health Problems: $_healthProblems');

    // Here you can add code to update the database with the new values

      try {
  final user = FirebaseAuth.instance.currentUser;
  final userid = user?.uid;
  print("User ID: $userid");
  final CollectionReference colref = FirebaseFirestore.instance.collection('Khao').doc(userid).collection('user_info');

  // Get documents from the collection
  final QuerySnapshot<Object?> querySnapshot = await colref.get();

  // Loop through the documents and update data
  querySnapshot.docs.forEach((doc) async {
    // Access data using doc.data()
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    // Perform null check before updating fields
    if (data != null) {
        int findHealthProblem(String problemToFind, List<String> healthProblems) {
      for (String problem in healthProblems) {
        if (problem.toLowerCase() == problemToFind.toLowerCase()) {
          return 1;
        }
      }
          return 0;
      }


      // Update fields
      await colref.doc(doc.id).update({
      'username':_username,
      'age':_age,
      'height':_height,
      'weight':_weight,
      'gender':_selectedGender,
      'non_veg':findHealthProblem('Non-veg',_foodTypes),
      'veg':findHealthProblem('Veg',_foodTypes),
      'vegan':findHealthProblem('Vegan',_foodTypes),
      'jain':findHealthProblem('Jain',_foodTypes),
      'gluten':findHealthProblem('Gluten',_allergens),
      'milk':findHealthProblem('Milk',_allergens),
      'soyabeans':findHealthProblem('Soyabeans',_allergens), 
      'diabetes':findHealthProblem('Diabetes',_healthProblems),
      'thyroid':findHealthProblem('Thyroid',_healthProblems),
      'pregnancy':findHealthProblem('Pregnancy',_healthProblems),
      'lactose_intolerant':0,
      });
    
      print('Document ${doc.id} updated successfully!');
    }
  });
} catch (e) {
  print('Error updating data in Firestore: $e');
}



    // Reset the editing flag after submission
    setState(() {
      _isEditing = false;
    });
  }

  void _enableEditing() {
    // Clear text fields before editing starts
    _usernameController.text = _username;
    _heightController.text = _height.toString();
    _weightController.text = _weight.toString();
    _ageController.text = _age.toString();

    setState(() {
      _isEditing = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Username'),
                      enabled: _isEditing,
                      onChanged: (value) {
                        setState(() {
                          _username = value;
                        });
                      },
                      controller: _usernameController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Icon(Icons.height),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Height'),
                      enabled: _isEditing,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _height = int.tryParse(value) ?? 0;
                        });
                      },
                      controller: _heightController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Icon(Icons.fitness_center),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Weight'),
                      enabled: _isEditing,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _weight = int.tryParse(value) ?? 0;
                        });
                      },
                      controller: _weightController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Age'),
                      enabled: _isEditing,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _age = int.tryParse(value) ?? 0;
                        });
                      },
                      controller: _ageController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'Gender',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _genderOptions.map((String gender) {
                  bool isSelected = _selectedGender == gender;
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: _isEditing
                            ? () {
                                setState(() {
                                  _selectedGender = gender;
                                });
                              }
                            : null,
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: isSelected ? Color(0xFFF6C90E) : (_isEditing ? Colors.grey[200] : Colors.transparent),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            gender,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              Text(
                'Food Type',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _foodTypesOptions.map((String foodType) {
                  bool isSelected = _foodTypes.contains(foodType);
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: _isEditing
                            ? () {
                                setState(() {
                                  if (isSelected) {
                                    _foodTypes.remove(foodType);
                                  } else {
                                    _foodTypes.add(foodType);
                                  }
                                });
                              }
                            : null,
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: isSelected ? Color(0xFFF6C90E) : (_isEditing ? Colors.grey[200] : Colors.transparent),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            foodType,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              Text(
                'Allergens',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _allergensOptions.map((String allergen) {
                  bool isSelected = _allergens.contains(allergen);
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: _isEditing
                            ? () {
                                setState(() {
                                  if (isSelected) {
                                    _allergens.remove(allergen);
                                  } else {
                                    _allergens.add(allergen);
                                  }
                                });
                              }
                            : null,
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: isSelected ? Color(0xFFF6C90E) : (_isEditing ? Colors.grey[200] : Colors.transparent),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            allergen,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              Text(
                'Health Problems',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _healthProblemsOptions.map((String healthProblem) {
                  bool isSelected = _healthProblems.contains(healthProblem);
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: _isEditing
                            ? () {
                                setState(() {
                                  if (isSelected) {
                                    _healthProblems.remove(healthProblem);
                                  } else {
                                    _healthProblems.add(healthProblem);
                                  }
                                });
                              }
                            : null,
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: isSelected ? Color(0xFFF6C90E) : (_isEditing ? Colors.grey[200] : Colors.transparent),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            healthProblem,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _isEditing ? _submitForm : _enableEditing,
                child: Text(_isEditing ? 'Submit' : 'Edit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
