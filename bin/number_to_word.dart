class NumberConverter {
  static const List<String> units = [
    "",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "seventeen",
    "eighteen",
    "nineteen",
  ];

  static const List<String> tens = [
    "",
    "",
    "twenty",
    "thirty",
    "forty",
    "fifty",
    "sixty",
    "seventy",
    "eighty",
    "ninety",
  ];

  /// Converts numbers 1-99 to words
  static String convertTwoDigits(int number) {
    if (number < 20) {
      return units[number];
    } else {
      int tensPlace = number ~/ 10;
      int unitsPlace = number % 10;
      return tens[tensPlace] + (unitsPlace > 0 ? " ${units[unitsPlace]}" : "");
    }
  }

  /// Converts numbers 1-999 to words
  static String convertThreeDigits(int number) {
    if (number == 0) return "";

    List<String> parts = [];

    // Handle hundreds
    if (number >= 100) {
      int hundreds = number ~/ 100;
      parts.add("${units[hundreds]} hundred");
      number %= 100;
    }

    // Handle tens and units
    if (number > 0) {
      parts.add(convertTwoDigits(number));
    }

    return parts.join(" ");
  }

  /// Main function to convert integer to words
  static String numberToWords(int number) {
    if (number == 0) return "zero";

    List<String> parts = [];

    // Handle millions
    if (number >= 1000000) {
      int millions = number ~/ 1000000;
      parts.add("${convertThreeDigits(millions)} million");
      number %= 1000000;
    }

    // Handle thousands
    if (number >= 1000) {
      int thousands = number ~/ 1000;
      parts.add("${convertThreeDigits(thousands)} thousand");
      number %= 1000;
    }

    // Handle hundreds
    if (number > 0) {
      parts.add(convertThreeDigits(number));
    }

    return parts.join(" ");
  }
}

// Test functions
void testNumberConverter() {
  print("=== Number Converter Tests ===");

  List<int> testCases = [0, 6, 42, 123, 900, 8379, 1234567, 1000000, 999999999];
  List<String> expected = [
    "zero",
    "six",
    "forty two",
    "one hundred twenty three",
    "nine hundred",
    "eight thousand three hundred seventy nine",
    "one million two hundred thirty four thousand five hundred sixty seven",
    "one million",
    "nine hundred ninety nine million nine hundred ninety nine thousand nine hundred ninety nine",
  ];

  for (int i = 0; i < testCases.length; i++) {
    String result = NumberConverter.numberToWords(testCases[i]);
    bool passed = result == expected[i];
    print("${testCases[i]} => \"$result\" ${passed ? '✓' : '✗'}");
    if (!passed) {
      print("  Expected: \"${expected[i]}\"");
    }
  }
}

void main() {
  testNumberConverter();
}
