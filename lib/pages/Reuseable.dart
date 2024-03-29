// ignore: file_names
import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

Image logowidget(String imagename){
      return Image.asset(
        imagename,
        fit: BoxFit.fitWidth,
        width: 350,
        height: 350,
        
      );
    }

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.black,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Color.fromARGB(0, 245, 222, 132).withOpacity(0.5),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}
Container firebaseUIButton(BuildContext context, String title, Function onTap, [Widget? leadingIcon]) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      // child: Text(
      //   title,
      //   style: const TextStyle(
      //       color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingIcon != null) leadingIcon,
          const SizedBox(width: 18), // Adjust the spacing between the icon and text
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              // Orange color when pressed
              return Color.fromARGB(255, 38, 50, 56); // Orange color (255, 165, 0)
            }
            // Normal state color
            return Color.fromARGB(255, 38, 50, 56); // Orange color (255, 165, 0)
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}
