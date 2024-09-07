// math_utils.dart

import 'dart:math';

/// A utility class providing a range of mathematical and data structure utilities.
class MathUtils {
  /// Computes the factorial of a number using an iterative approach.
  int factorial(int n) {
    if (n < 0) throw ArgumentError('Negative numbers are not allowed');
    int result = 1;
    for (int i = 2; i <= n; i++) {
      result *= i;
    }
    return result;
  }

  /// Checks if a given number is a perfect square.
  bool isPerfectSquare(int number) {
    if (number < 0) return false;
    int sqrtNum = sqrt(number).toInt();
    return sqrtNum * sqrtNum == number;
  }

  /// Checks if a number is a perfect cube.
  bool isPerfectCube(int number) {
    if (number < 0) return false;
    int cubeRoot = pow(number, 1/3).round();
    return cubeRoot * cubeRoot * cubeRoot == number;
  }

  /// Computes the nth triangular number.
  int triangularNumber(int n) {
    if (n < 0) throw ArgumentError('Negative numbers are not allowed');
    return n * (n + 1) ~/ 2;
  }

  /// Computes the sum of the digits of a number.
  int sumOfDigits(int number) {
    return number
        .toString()
        .split('')
        .map(int.parse)
        .reduce((a, b) => a + b);
  }

  /// Finds all divisors of a number.
  List<int> findDivisors(int number) {
    if (number <= 0) throw ArgumentError('Number must be positive');
    List<int> divisors = [];
    for (int i = 1; i <= sqrt(number); i++) {
      if (number % i == 0) {
        divisors.add(i);
        if (i != number ~/ i) divisors.add(number ~/ i);
      }
    }
    return divisors..sort();
  }

  /// Calculates the digital root of a number.
  int digitalRoot(int number) {
    return 1 + (number - 1) % 9;
  }

  /// Checks if a number is a power of two.
  bool isPowerOfTwo(int number) {
    return number > 0 && (number & (number - 1)) == 0;
  }

  /// Finds the Greatest Common Divisor (GCD) of a list of numbers.
  int gcdList(List<int> numbers) {
    return numbers.reduce((a, b) => _gcd(a, b));
  }

  /// Helper method to calculate the GCD of two numbers.
  int _gcd(int a, int b) {
    return b == 0 ? a : _gcd(b, a % b);
  }

  /// Generates a list of Fibonacci numbers up to the nth number.
  List<int> generateFibonacci(int n) {
    if (n <= 0) return [];
    List<int> fibonacciList = [0, 1];
    for (int i = 2; i < n; i++) {
      fibonacciList.add(fibonacciList[i - 1] + fibonacciList[i - 2]);
    }
    return fibonacciList;
  }

  /// Computes the binomial coefficient, also known as "n choose k".
  int binomialCoefficient(int n, int k) {
    if (k < 0 || k > n) return 0;
    k = min(k, n - k); // Take advantage of symmetry
    int c = 1;
    for (int i = 0; i < k; i++) {
      c = c * (n - i) ~/ (i + 1);
    }
    return c;
  }

  /// Checks if a number is a strong number (sum of factorials of its digits equals the number).
  bool isStrongNumber(int number) {
    int sum = number
        .toString()
        .split('')
        .map((digit) => factorial(int.parse(digit)))
        .reduce((a, b) => a + b);
    return sum == number;
  }

  /// Computes the number of trailing zeros in the factorial of a given number.
  int trailingZerosInFactorial(int n) {
    int count = 0;
    for (int i = 5; n ~/ i > 0; i *= 5) {
      count += n ~/ i;
    }
    return count;
  }

  /// Converts a decimal number to its binary representation.
  String toBinary(int number) {
    return number.toRadixString(2);
  }

  /// Converts a decimal number to its octal representation.
  String toOctal(int number) {
    return number.toRadixString(8);
  }

  /// Converts a decimal number to its hexadecimal representation.
  String toHexadecimal(int number) {
    return number.toRadixString(16).toUpperCase();
  }

  /// Checks if a given number is a prime.
  bool isPrime(int number) {
    if (number <= 1) return false;
    for (int i = 2; i <= sqrt(number).toInt(); i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  /// Generates all prime numbers up to a given limit using the Sieve of Eratosthenes.
  List<int> generatePrimes(int limit) {
    if (limit <= 1) return [];
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

  /// Calculates the sum of the first n prime numbers.
  int sumOfPrimes(int n) {
    int count = 0;
    int sum = 0;
    int number = 2;
    while (count < n) {
      if (isPrime(number)) {
        sum += number;
        count++;
      }
      number++;
    }
    return sum;
  }

  /// Computes the square root of a number using Newton's method.
  double sqrtNewton(double number) {
    if (number < 0) throw ArgumentError('Cannot compute square root of negative number');
    double x = number;
    double root;
    while (true) {
      root = 0.5 * (x + number / x);
      if ((root - x).abs() < 0.000001) break;
      x = root;
    }
    return root;
  }

  /// Solves a quadratic equation given coefficients a, b, and c.
  List<double> solveQuadratic(double a, double b, double c) {
    double discriminant = b * b - 4 * a * c;
    if (discriminant < 0) return [];
    double sqrtDiscriminant = sqrt(discriminant);
    double root1 = (-b + sqrtDiscriminant) / (2 * a);
    double root2 = (-b - sqrtDiscriminant) / (2 * a);
    return [root1, root2];
  }

  /// Computes the sum of an arithmetic series given the first term, common difference, and number of terms.
  int sumArithmeticSeries(int firstTerm, int commonDifference, int numberOfTerms) {
    return (numberOfTerms / 2 * (2 * firstTerm + (numberOfTerms - 1) * commonDifference)).toInt();
  }

  /// Computes the sum of a geometric series given the first term, common ratio, and number of terms.
  double sumGeometricSeries(double firstTerm, double commonRatio, int numberOfTerms) {
    if (commonRatio == 1) return firstTerm * numberOfTerms;
    return firstTerm * (1 - pow(commonRatio, numberOfTerms)) / (1 - commonRatio);
  }

  /// Generates a list of n random integers within a specified range.
  List<int> generateRandomIntegers(int n, int min, int max) {
    Random random = Random();
    return List.generate(n, (_) => min + random.nextInt(max - min + 1));
  }

  /// Solves a linear equation ax + b = 0.
  double solveLinearEquation(double a, double b) {
    if (a == 0) throw ArgumentError('Coefficient a cannot be zero');
    return -b / a;
  }

  /// Finds the maximum value in a list of numbers.
  num findMax(List<num> numbers) {
    if (numbers.isEmpty) throw ArgumentError('The list cannot be empty');
    return numbers.reduce(max);
  }

  /// Finds the minimum value in a list of numbers.
  num findMin(List<num> numbers) {
    if (numbers.isEmpty) throw ArgumentError('The list cannot be empty');
    return numbers.reduce(min);
  }

  /// Checks if a number is an automorphic number.
  bool isAutomorphic(int number) {
    int square = number * number;
    return square.toString().endsWith(number.toString());
  }
}
