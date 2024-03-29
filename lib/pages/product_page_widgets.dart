import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;




class Pinfo extends StatefulWidget {
  final String pname;
  final String pimage;
  final String pweight;
  const Pinfo(
      {Key? key,
      required this.pname,
      required this.pimage,
      required this.pweight})
      : super(key: key);

  @override
  State<Pinfo> createState() => _PinfoState();
}

class _PinfoState extends State<Pinfo> {
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
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          alignment: Alignment.center,
          child: Text(widget.pname,
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 20),
        Image.network(
          widget.pimage, // Your image URL here
          width: 150,
          height: 150,
        ),
        SizedBox(height: 5),
        Container(
          alignment: Alignment.centerRight,
          child: Text(widget.pweight,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              )),
        ),
      ]),
    );
  }
}

class Warning extends StatefulWidget {
  final String warn;
  const Warning({Key? key, required this.warn}) : super(key: key);

  @override
  State<Warning> createState() => _WarningState();
}

class _WarningState extends State<Warning> {
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
      child: Row(
        children: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.warning_rounded,
                color: const Color.fromARGB(255, 235, 212, 4),
                size: 40.0,
              )),
          Expanded(
            child: Text(widget.warn,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                )),
          ),
        ],
      ),
    );
  }
}

class Scores extends StatefulWidget {
  final String nutri_Score;
  final String nova_Score;
  const Scores({Key? key, required this.nutri_Score, required this.nova_Score})
      : super(key: key);

  @override
  State<Scores> createState() => _ScoresState();
}

class _ScoresState extends State<Scores> {
  @override
  Widget build(BuildContext context) {
    Widget categoryIcon;
    Widget categoryIcons;
    switch (widget.nutri_Score) {
      case 'a':
        categoryIcon = Container(
            width: 120, height: 75, child: Image.asset('assets/nutri_a.png'));
        break;

      case 'b':
        categoryIcon = Container(
            width: 40, height: 40, child: Image.asset('assets/nutri_b.png'));
        break;

      case 'c':
        categoryIcon = Container(
            width: 40, height: 40, child: Image.asset('assets/nutri_c.png'));
        break;

      case 'd':
        categoryIcon = Container(
            width: 40, height: 40, child: Image.asset('assets/nutri_d.png'));
        break;

      case 'e':
        categoryIcon = Container(
            width: 40, height: 40, child: Image.asset('assets/nutri_e.png'));
        break;

      default:
        categoryIcon = Container(
            width: 40, height: 40, child: Image.asset('assets/nutri_d.png'));
        break;
    }
    switch (widget.nova_Score) {
      case '1':
        categoryIcons = Container(
            width: 120,
            height: 75,
            child: SvgPicture.asset('assets/nova_1.svg'));
        break;

      case '2':
        categoryIcons = Container(
            width: 40,
            height: 40,
            child: SvgPicture.asset('assets/nova_2.svg'));
        break;

      case '3':
        categoryIcons = Container(
            width: 40,
            height: 40,
            child: SvgPicture.asset('assets/nova_3.svg'));
        break;

      case '4':
        categoryIcons = Container(
            width: 40,
            height: 40,
            child: SvgPicture.asset('assets/nova_4.svg'));
        break;

      default:
        categoryIcons = Container(
            width: 40,
            height: 40,
            child: SvgPicture.asset('assets/nova_4.svg'));
        break;
    }

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
          Text('Category',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Nutri Score",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    categoryIcon,
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Nova Score",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    categoryIcons,
                  ],
                )
              ])
        ],
      ),
    );
  }
}

class Nutrition_panel extends StatefulWidget {
  final Map<String, String> nutrition_data;
  const Nutrition_panel({Key? key, required this.nutrition_data})
      : super(key: key);

  @override
  State<Nutrition_panel> createState() => _Nutrition_panelState();
}

class _Nutrition_panelState extends State<Nutrition_panel> {
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
          Text('Nutrition',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.nutrition_data.entries.map((entry) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    entry.value.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class J_veg_nveg_vegan extends StatefulWidget {
  final String kyahai;
  const J_veg_nveg_vegan({Key? key, required this.kyahai}) : super(key: key);

  @override
  State<J_veg_nveg_vegan> createState() => _J_veg_nveg_veganState();
}

class _J_veg_nveg_veganState extends State<J_veg_nveg_vegan> {
  @override
  Widget build(BuildContext context) {
    Widget categoryIcon;
    switch (widget.kyahai) {
      case 'jain':
        categoryIcon = Container(
            width: 40, height: 40, child: SvgPicture.asset('assets/jain.svg'));
        break;

      case 'vegan':
        categoryIcon = Container(
            width: 40, height: 40, child: SvgPicture.asset('assets/vegan.svg'));
        break;

      case 'Non Vegetarian':
        categoryIcon = Container(
            width: 40,
            height: 40,
            child: SvgPicture.asset('assets/nonveg.svg'));
        break;

      case 'Vegetarian':
        categoryIcon = Container(
            width: 40, height: 40, child: SvgPicture.asset('assets/veg.svg'));
        break;

      default:
        categoryIcon = Container(
            width: 40, height: 40, child: SvgPicture.asset('assets/jain.svg'));
        break;
    }
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
          Text('Category',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    categoryIcon,
                    Text(widget.kyahai,
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold))
                  ],
                )
              ])
        ],
      ),
    );
  }
}


class Allergents extends StatefulWidget {
  final String aller;
  const Allergents({Key? key, required this.aller}) : super(key: key);

  @override
  State<Allergents> createState() => _AllergentsState();
}

class _AllergentsState extends State<Allergents> {
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
          Text('Allergents',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Column(
            children: <Widget>[
              Text(
                widget.aller,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Ingridients extends StatefulWidget {
  final String ingri;
  const Ingridients({Key? key, required this.ingri}) : super(key: key);

  @override
  State<Ingridients> createState() => _IngridientsState();
}

class _IngridientsState extends State<Ingridients> {
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
          Text('Ingredients',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Column(
            children: <Widget>[
              Text(
                widget.ingri,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

