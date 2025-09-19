class FlatSum {
  static int sumAscii(String s) {
    int sum = 0;
    for (final rune in s.runes) {
      // Use an if-case with a pattern guard to match valid ASCII characters.
      if (rune case final r when r >= 0 && r <= 127) {
        sum += r;
      }
    }
    return sum;
  }

  // Helper Function for Records
  static int sumRecord(dynamic rec) {
    if (rec case (int a, int b)) return a + b;
    if (rec case (String s, int n)) return sumAscii(s) + n;
    if (rec case (int n, String s)) return n + sumAscii(s);

    // For more complex or nested records, use a switch to destructure
    // and recursively call sumNested on each part.
    switch (rec) {
      case (var a, var b): // Positional
        return sumNested(a) + sumNested(b);
      case (first: var a, second: var b): // Named
        return sumNested(a) + sumNested(b);
      default:
        return 0; // Should not be reached for valid 2-element records
    }
  }

  // Helper for Lists (Demonstrating List Patterns)
  static int sumSpecialList(List<dynamic> l) {
    switch (l) {
      // Base case: empty list
      case []:
        return 0;
      // Case: list starts with an integer
      case [int head, ...final tail]:
        return head + sumSpecialList(tail);
      // Case: list starts with a string
      case [String head, ...final tail]:
        return sumAscii(head) + sumSpecialList(tail);
      // Fallback for any other type at the head of the list
      case [final head, ...final tail]:
        return sumNested(head) + sumSpecialList(tail);
      default:
        return 0;
    }
  }

  static int sumNested(dynamic obj) {
    switch (obj) {
      // For primitives
      case int n:
        return n;
      case double d:
        return d.floor();
      case String s:
        return sumAscii(s);

      case List<dynamic> list:
        return list.fold(0, (sum, item) => sum + sumNested(item));
      case Map<dynamic, dynamic> map:
        return map.values.fold(0, (sum, value) => sum + sumNested(value));

      case (var _, var _): // Matches any 2-element positional record
        return sumRecord(obj);
      case (first: var _, second: var _): // Matches any 2-element named record
        return sumRecord(obj);

      // Wildcard for other types
      case _:
        return 0;
    }
  }
}


// Main Function for Testing
void main() {
  final data = [
    1,
    [2, 3, 4],
    {
      'a': 5,
      'b': ["ab", 7],
    },
    (first: 8, second: "c"),
    {
      'c': (first: 10, second: ["xy", 12]),
    },
    "z",
    13.5,
    [
      14,
      {'d': 15, 'e': (first: "p", second: 17)},
    ],
  ];

  final totalSum = FlatSum.sumNested(data);
  print("Calculated Sum: $totalSum");
  print("Expected Sum: 880");
  print("Result matches expected: ${totalSum == 880}\n");

  print("List Pattern Helper (sumSpecialList)");

  final specialList = [
    10,
    "hello",
    [1, 2],
    -5.5,
  ];

  final specialSum = FlatSum.sumSpecialList(specialList);
  print("List to process: $specialList");
  print("Calculated Sum: $specialSum");
  print("Expected Sum: 539\n");
}
