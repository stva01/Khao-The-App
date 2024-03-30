import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String _username = '';
  int _age = 0;
  int _height = 0;
  int _weight = 0;
  String? _selectedGender;
  List<String> _foodTypes = [];
  List<String> _allergens = [];
  List<String> _healthProblems = [];

  final List<String> _foodTypesOptions = ['Non-veg', 'Veg', 'Jain', 'Vegan'];
  final List<String> _allergensOptions = ['Gluten', 'Milk', 'Soyabeans'];
  final List<String> _healthProblemsOptions = ['Diabetes', 'Thyroid', 'Pregnancy'];
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  void nextPage() {
    if (_currentPageIndex < 1) {
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void previousPage() {
    if (_currentPageIndex > 0) {
      _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }



  void _submitForm() {
    // Implement your logic here to handle form submission
    print('Username: $_username');
    print('Height: $_height');
    print('Weight: $_weight');
    print('Age: $_age');
    print('Gender: $_selectedGender');
    print('Food Types: $_foodTypes');
    print('Allergens: $_allergens');
    print('Health Problems: $_healthProblems');
    int findHealthProblem(String problemToFind, List<String> healthProblems) {
    for (String problem in healthProblems) {
      if (problem.toLowerCase() == problemToFind.toLowerCase()) {
        return 1;
      }
    }
    return 0;
  }
    final user = FirebaseAuth.instance.currentUser;
    final userid=user?.uid;
    try {
    CollectionReference colref = FirebaseFirestore.instance.collection('Khao').doc(userid).collection('user_info');
    colref.add({
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
      print('User Details added to Firestore successfully!');  
    }
    catch (e) {
      print('Error adding User Details to Firestore: $e');
      }
    Navigator.pushReplacementNamed(context,'/home');

}







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              children: [
                // First Page
                Padding(
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
                                onChanged: (value) {
                                  setState(() {
                                    _username = value;
                                  });
                                },
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
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    _height = int.tryParse(value) ?? 0;
                                  });
                                },
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
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    _weight = int.tryParse(value) ?? 0;
                                  });
                                },
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
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    _age = int.tryParse(value) ?? 0;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Gender',
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        // Gender selection using Radio
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _genderOptions.map((String gender) {
                            bool isSelected = _selectedGender == gender;
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedGender = gender;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(12.0),
                                    margin: EdgeInsets.symmetric(vertical: 4.0),
                                    decoration: BoxDecoration(
                                      color: isSelected ? Color(0xFFF6C90E) : Colors.grey[200],
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
                                SizedBox(width: 8.0), // Adjust the width as per your preference
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                // Second Page
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Food Type',
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        // Food types selection
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _foodTypesOptions.map((String foodType) {
                              bool isSelected = _foodTypes.contains(foodType);
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isSelected) {
                                          _foodTypes.remove(foodType);
                                        } else {
                                          _foodTypes.add(foodType);
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(12.0),
                                      margin: EdgeInsets.symmetric(vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color: isSelected ? Color(0xFFF6C90E) : Colors.grey[200],
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
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Allergens',
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        // Allergens selection
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _allergensOptions.map((String allergen) {
                              bool isSelected = _allergens.contains(allergen);
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isSelected) {
                                          _allergens.remove(allergen);
                                        } else {
                                          _allergens.add(allergen);
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(12.0),
                                      margin: EdgeInsets.symmetric(vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color: isSelected ? Color(0xFFF6C90E) : Colors.grey[200],
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
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Health Problems',
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        // Health problems selection
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _healthProblemsOptions.map((String healthProblem) {
                              bool isSelected = _healthProblems.contains(healthProblem);
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isSelected) {
                                          _healthProblems.remove(healthProblem);
                                        } else {
                                          _healthProblems.add(healthProblem);
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(12.0),
                                      margin: EdgeInsets.symmetric(vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color: isSelected ? Color(0xFFF6C90E) : Colors.grey[200],
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
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: Text('Submit'),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPageIndex == 0 ? Color(0xFFF6C90E) : Colors.grey,
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPageIndex == 1 ? Color(0xFFF6C90E) : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
