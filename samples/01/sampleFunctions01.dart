// app_helpers.dart

import 'dart:math';

/// A helper class that provides various utility functions for the Flutter application.
class AppHelpers {
  /// Generates a random integer between [min] and [max].
  int generateRandomInt(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min);
  }

  /// Calculates the factorial of a number using recursion.
  int calculateFactorial(int number) {
    if (number <= 1) return 1;
    return number * calculateFactorial(number - 1);
  }

  /// Reverses a given string.
  String reverseString(String input) {
    return input.split('').reversed.join();
  }

  /// Formats a given [DateTime] object to a readable string format.
  String formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}";
  }

  /// Converts a given string to title case.
  String toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  /// Checks if the given number is a prime number.
  bool isPrime(int number) {
    if (number <= 1) return false;
    for (var i = 2; i <= sqrt(number).toInt(); i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  /// Generates a list of prime numbers up to a given limit.
  List<int> generatePrimeNumbers(int limit) {
    List<int> primes = [];
    for (var i = 2; i <= limit; i++) {
      if (isPrime(i)) primes.add(i);
    }
    return primes;
  }

  /// Computes the Greatest Common Divisor (GCD) of two numbers using the Euclidean algorithm.
  int gcd(int a, int b) {
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  /// Checks if a given year is a leap year.
  bool isLeapYear(int year) {
    if (year % 4 != 0) return false;
    if (year % 100 != 0) return true;
    if (year % 400 == 0) return true;
    return false;
  }

  /// Finds the nth Fibonacci number using memoization for optimization.
  int fibonacci(int n, [Map<int, int>? memo]) {
    memo ??= {};
    if (n <= 1) return n;
    if (memo.containsKey(n)) return memo[n]!;
    memo[n] = fibonacci(n - 1, memo) + fibonacci(n - 2, memo);
    return memo[n]!;
  }

  /// Validates an email address using a simple regular expression.
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Calculates the distance between two points (x1, y1) and (x2, y2) in 2D space.
  double calculateDistance(double x1, double y1, double x2, double y2) {
    return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
  }

  /// Converts a given list of integers to a comma-separated string.
  String listToCommaSeparatedString(List<int> numbers) {
    return numbers.join(', ');
  }

  /// Finds the longest word in a given sentence.
  String findLongestWord(String sentence) {
    List<String> words = sentence.split(' ');
    String longestWord = '';
    for (var word in words) {
      if (word.length > longestWord.length) {
        longestWord = word;
      }
    }
    return longestWord;
  }

  /// Simulates a dice roll and returns a random number between 1 and 6.
  int rollDice() {
    return Random().nextInt(6) + 1;
  }

  /// Generates a random password of a given length.
  String generateRandomPassword(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()';
    Random random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }
}
