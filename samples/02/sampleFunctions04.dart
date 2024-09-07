// advanced_utils.dart

import 'dart:convert';
import 'dart:math';

/// A utility class providing a range of advanced functionalities.
class AdvancedUtils {
  /// Checks if a number is a palindrome.
  bool isPalindrome(int number) {
    String numStr = number.toString();
    String reversedStr = numStr.split('').reversed.join('');
    return numStr == reversedStr;
  }

  /// Calculates the nth Fibonacci number using an iterative approach.
  int fibonacciIterative(int n) {
    if (n <= 1) return n;
    int a = 0, b = 1, sum = 0;
    for (int i = 2; i <= n; i++) {
      sum = a + b;
      a = b;
      b = sum;
    }
    return sum;
  }

  /// Converts a list of integers to a hexadecimal string.
  String convertToHex(List<int> numbers) {
    return numbers.map((e) => e.toRadixString(16).padLeft(2, '0')).join();
  }

  /// Computes the Greatest Common Divisor (GCD) using recursion.
  int gcdRecursive(int a, int b) {
    return b == 0 ? a : gcdRecursive(b, a % b);
  }

  /// Computes the Least Common Multiple (LCM) of two numbers.
  int lcm(int a, int b) {
    return (a * b) ~/ gcdRecursive(a, b);
  }

  /// Flattens a nested list of integers.
  List<int> flattenList(List<dynamic> nestedList) {
    List<int> result = [];
    for (var element in nestedList) {
      if (element is List) {
        result.addAll(flattenList(element));
      } else if (element is int) {
        result.add(element);
      }
    }
    return result;
  }

  /// Converts a binary string to a decimal integer.
  int binaryToDecimal(String binary) {
    return int.parse(binary, radix: 2);
  }

  /// Converts a decimal integer to a binary string.
  String decimalToBinary(int decimal) {
    return decimal.toRadixString(2);
  }

  /// Calculates the Hamming distance between two binary strings.
  int hammingDistance(String bin1, String bin2) {
    if (bin1.length != bin2.length) {
      throw ArgumentError('Binary strings must be of the same length.');
    }
    int distance = 0;
    for (int i = 0; i < bin1.length; i++) {
      if (bin1[i] != bin2[i]) distance++;
    }
    return distance;
  }

  /// Performs Run-Length Encoding on a string.
  String runLengthEncode(String input) {
    if (input.isEmpty) return '';
    StringBuffer result = StringBuffer();
    int count = 1;
    for (int i = 1; i < input.length; i++) {
      if (input[i] == input[i - 1]) {
        count++;
      } else {
        result.write('${input[i - 1]}$count');
        count = 1;
      }
    }
    result.write('${input[input.length - 1]}$count');
    return result.toString();
  }

  /// Performs Run-Length Decoding on a string.
  String runLengthDecode(String input) {
    if (input.isEmpty) return '';
    StringBuffer result = StringBuffer();
    for (int i = 0; i < input.length; i += 2) {
      String char = input[i];
      int count = int.parse(input[i + 1]);
      result.write(char * count);
    }
    return result.toString();
  }

  /// Converts a Roman numeral string to an integer.
  int romanToInteger(String roman) {
    Map<String, int> romanMap = {
      'I': 1,
      'V': 5,
      'X': 10,
      'L': 50,
      'C': 100,
      'D': 500,
      'M': 1000
    };

    int result = 0;
    for (int i = 0; i < roman.length; i++) {
      if (i + 1 < roman.length &&
          romanMap[roman[i]]! < romanMap[roman[i + 1]]!) {
        result -= romanMap[roman[i]]!;
      } else {
        result += romanMap[roman[i]]!;
      }
    }
    return result;
  }

  /// Generates all permutations of a given string.
  List<String> generatePermutations(String input) {
    List<String> result = [];
    _permuteHelper(input.split(''), 0, result);
    return result;
  }

  /// Helper function to generate permutations recursively.
  void _permuteHelper(List<String> chars, int start, List<String> result) {
    if (start == chars.length - 1) {
      result.add(chars.join());
      return;
    }
    for (int i = start; i < chars.length; i++) {
      _swap(chars, start, i);
      _permuteHelper(chars, start + 1, result);
      _swap(chars, start, i); // backtrack
    }
  }

  /// Swaps two elements in a list.
  void _swap(List<String> chars, int i, int j) {
    String temp = chars[i];
    chars[i] = chars[j];
    chars[j] = temp;
  }

  /// Evaluates a postfix expression (Reverse Polish Notation).
  int evaluatePostfix(String expression) {
    List<int> stack = [];
    for (var char in expression.split(' ')) {
      if (RegExp(r'\d+').hasMatch(char)) {
        stack.add(int.parse(char));
      } else {
        int b = stack.removeLast();
        int a = stack.removeLast();
        switch (char) {
          case '+':
            stack.add(a + b);
            break;
          case '-':
            stack.add(a - b);
            break;
          case '*':
            stack.add(a * b);
            break;
          case '/':
            stack.add(a ~/ b);
            break;
        }
      }
    }
    return stack.last;
  }

  /// Calculates the n-th Catalan number.
  int catalanNumber(int n) {
    if (n <= 1) return 1;
    int result = 0;
    for (int i = 0; i < n; i++) {
      result += catalanNumber(i) * catalanNumber(n - i - 1);
    }
    return result;
  }

  /// Checks if a given string is a valid palindrome considering only alphanumeric characters.
  bool isValidPalindrome(String s) {
    s = s.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
    int left = 0;
    int right = s.length - 1;
    while (left < right) {
      if (s[left] != s[right]) return false;
      left++;
      right--;
    }
    return true;
  }

  /// Generates a list of prime numbers up to a specified limit using the Sieve of Eratosthenes.
  List<int> sieveOfEratosthenes(int limit) {
    List<bool> sieve = List.filled(limit + 1, true);
    sieve[0] = sieve[1] = false; // 0 and 1 are not prime numbers
    for (int i = 2; i * i <= limit; i++) {
      if (sieve[i]) {
        for (int j = i * i; j <= limit; j += i) {
          sieve[j] = false;
        }
      }
    }
    return [for (int i = 2; i <= limit; i++) if (sieve[i]) i];
  }

  /// Finds the Longest Common Subsequence (LCS) between two strings.
  String longestCommonSubsequence(String s1, String s2) {
    List<List<int>> dp = List.generate(s1.length + 1,
        (_) => List.generate(s2.length + 1, (_) => 0));

    for (int i = 1; i <= s1.length; i++) {
      for (int j = 1; j <= s2.length; j++) {
        if (s1[i - 1] == s2[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1] + 1;
        } else {
          dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]);
        }
      }
    }

    // Backtrack to find the LCS string
    StringBuffer lcs = StringBuffer();
    int i = s1.length, j = s2.length;
    while (i > 0 && j > 0) {
      if (s1[i - 1] == s2[j - 1]) {
        lcs.write(s1[i - 1]);
        i--;
        j--;
      } else if (dp[i - 1][j] > dp[i][j - 1]) {
        i--;
      } else {
        j--;
      }
    }
    return lcs.toString().split('').reversed.join('');
  }

  /// Computes the power of a number using exponentiation by squaring.
  double power(double base, int exponent) {
    if (exponent == 0) return 1;
    double half = power(base, exponent ~/ 2);
    if (exponent % 2 == 0) {
      return half * half;
    } else {
      return base * half * half;
    }
  }

  /// Checks if a number is an Armstrong number.
  bool isArmstrong(int number) {
    String numStr = number.toString();
    int sum = numStr.split('').fold(0, (int sum, String digit) {
      return sum + pow(int.parse(digit), numStr.length).toInt();
    });
    return sum == number;
  }
}
