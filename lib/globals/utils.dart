import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils{

  String convertToShortString(String inputString) {
    if (inputString.length <= 25) {
      return inputString; // No need to convert, return the original string.
    } else {
      return '${inputString.substring(0, 22)}...'; // Clip the string and add "..." at the end.
    }
  }

  Color hexStringToColor(String hexColor) {
    // Remove the '#' character if it exists
    hexColor = hexColor.replaceAll("#", "");

    // Parse the hexadecimal color string to an integer
    int hexValue = int.parse(hexColor, radix: 16);

    // Create a Color object
    return Color(hexValue | 0xFF000000);
  }

  String convertDateFormat(String originalDateString) {
    if (originalDateString.isNotEmpty) {
      try {
        // Parse the original date string to DateTime
        DateTime originalDate = DateTime.parse(originalDateString);

        // Format the date using the intl package
        String formattedDateString = DateFormat('MM/dd/yyyy').format(originalDate);

        return formattedDateString;
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
      }
    }
    return '';
  }
}