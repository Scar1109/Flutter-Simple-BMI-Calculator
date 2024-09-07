// data_processing.dart

import 'dart:convert';
import 'dart:math';

/// A class that provides various data processing utilities for the application.
class DataProcessing {
  /// Sorts a list of integers using the Merge Sort algorithm.
  List<int> mergeSort(List<int> list) {
    if (list.length <= 1) return list;

    int middle = list.length ~/ 2;
    List<int> left = mergeSort(list.sublist(0, middle));
    List<int> right = mergeSort(list.sublist(middle));

    return _merge(left, right);
  }

  /// Merges two sorted lists into one sorted list.
  List<int> _merge(List<int> left, List<int> right) {
    List<int> result = [];
    int i = 0, j = 0;

    while (i < left.length && j < right.length) {
      if (left[i] <= right[j]) {
        result.add(left[i++]);
      } else {
        result.add(right[j++]);
      }
    }

    result.addAll(left.sublist(i));
    result.addAll(right.sublist(j));

    return result;
  }

  /// Encodes a given object into a JSON string.
  String encodeToJson(Object object) {
    return jsonEncode(object);
  }

  /// Decodes a JSON string into a Map object.
  Map<String, dynamic> decodeFromJson(String jsonString) {
    return jsonDecode(jsonString);
  }

  /// Performs a binary search on a sorted list of integers.
  int binarySearch(List<int> sortedList, int target) {
    int left = 0;
    int right = sortedList.length - 1;

    while (left <= right) {
      int middle = left + (right - left) ~/ 2;

      if (sortedList[middle] == target) return middle;
      if (sortedList[middle] < target) {
        left = middle + 1;
      } else {
        right = middle - 1;
      }
    }

    return -1; // Target not found
  }

  /// Performs a quick sort on a list of integers.
  List<int> quickSort(List<int> list) {
    if (list.length <= 1) return list;

    int pivot = list[list.length ~/ 2];
    List<int> less = [];
    List<int> more = [];
    List<int> pivotList = [];

    for (var num in list) {
      if (num < pivot) {
        less.add(num);
      } else if (num > pivot) {
        more.add(num);
      } else {
        pivotList.add(num);
      }
    }

    return quickSort(less) + pivotList + quickSort(more);
  }

  /// Computes the average of a list of numbers.
  double computeAverage(List<num> numbers) {
    if (numbers.isEmpty) return 0;
    num sum = numbers.reduce((a, b) => a + b);
    return sum / numbers.length;
  }

  /// Normalizes a list of numbers to a 0-1 scale.
  List<double> normalize(List<num> numbers) {
    if (numbers.isEmpty) return [];
    num minVal = numbers.reduce(min);
    num maxVal = numbers.reduce(max);

    return numbers.map((num value) {
      return (value - minVal) / (maxVal - minVal);
    }).toList();
  }

  /// Calculates the standard deviation of a list of numbers.
  double calculateStandardDeviation(List<num> numbers) {
    double avg = computeAverage(numbers);
    double sumSquaredDiff = numbers.fold(0, (sum, num) => sum + pow(num - avg, 2));
    return sqrt(sumSquaredDiff / numbers.length);
  }

  /// Finds the median of a list of numbers.
  double findMedian(List<num> numbers) {
    if (numbers.isEmpty) return 0;
    List<num> sorted = [...numbers]..sort();
    int middle = sorted.length ~/ 2;
    if (sorted.length % 2 == 1) {
      return sorted[middle].toDouble();
    } else {
      return (sorted[middle - 1] + sorted[middle]) / 2;
    }
  }

  /// Generates a random string of a given length.
  String generateRandomString(int length) {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return List.generate(length, (index) => characters[random.nextInt(characters.length)]).join();
  }

  /// Encrypts a string using a basic Caesar cipher with a given shift.
  String caesarCipherEncrypt(String text, int shift) {
    return String.fromCharCodes(text.codeUnits.map((unit) {
      if (unit >= 65 && unit <= 90) {
        return ((unit - 65 + shift) % 26) + 65; // Uppercase
      } else if (unit >= 97 && unit <= 122) {
        return ((unit - 97 + shift) % 26) + 97; // Lowercase
      } else {
        return unit; // Non-alphabetical characters remain unchanged
      }
    }));
  }

  /// Decrypts a string that was encrypted with a Caesar cipher.
  String caesarCipherDecrypt(String text, int shift) {
    return caesarCipherEncrypt(text, 26 - shift);
  }

  /// Calculates the Jaccard similarity coefficient between two sets.
  double calculateJaccardSimilarity(Set setA, Set setB) {
    int intersectionCount = setA.intersection(setB).length;
    int unionCount = setA.union(setB).length;
    return intersectionCount / unionCount;
  }

  /// Checks if a list of numbers contains any duplicates.
  bool containsDuplicates(List<int> numbers) {
    Set<int> uniqueNumbers = {};
    for (var number in numbers) {
      if (!uniqueNumbers.add(number)) {
        return true; // Duplicate found
      }
    }
    return false;
  }

  /// Performs matrix multiplication on two 2D matrices.
  List<List<num>> matrixMultiply(List<List<num>> matrixA, List<List<num>> matrixB) {
    int rowsA = matrixA.length;
    int colsA = matrixA[0].length;
    int colsB = matrixB[0].length;

    List<List<num>> result = List.generate(rowsA, (_) => List.filled(colsB, 0));

    for (int i = 0; i < rowsA; i++) {
      for (int j = 0; j < colsB; j++) {
        for (int k = 0; k < colsA; k++) {
          result[i][j] += matrixA[i][k] * matrixB[k][j];
        }
      }
    }
    return result;
  }

  /// Transposes a 2D matrix.
  List<List<num>> transposeMatrix(List<List<num>> matrix) {
    int rows = matrix.length;
    int cols = matrix[0].length;
    List<List<num>> transposed = List.generate(cols, (_) => List.filled(rows, 0));

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        transposed[j][i] = matrix[i][j];
      }
    }
    return transposed;
  }

  /// Calculates the mode of a list of numbers.
  List<num> findMode(List<num> numbers) {
    Map<num, int> frequencyMap = {};
    int maxFrequency = 0;
    List<num> modes = [];

    for (var number in numbers) {
      frequencyMap[number] = (frequencyMap[number] ?? 0) + 1;
      maxFrequency = max(maxFrequency, frequencyMap[number]!);
    }

    frequencyMap.forEach((key, value) {
      if (value == maxFrequency) modes.add(key);
    });

    return modes;
  }

  /// Generates a list of random integers within a specified range.
  List<int> generateRandomIntList(int length, int min, int max) {
    Random random = Random();
    return List.generate(length, (_) => min + random.nextInt(max - min + 1));
  }

  /// Shuffles a list of integers randomly.
  void shuffleList(List<int> list) {
    Random random = Random();
    for (int i = list.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      var temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
  }

  /// Computes the nth triangular number.
  int computeTriangularNumber(int n) {
    return (n * (n + 1)) ~/ 2;
  }

  /// Calculates the cumulative sum of a list of numbers.
  List<num> cumulativeSum(List<num> numbers) {
    List<num> result = [];
    num sum = 0;
    for (var number in numbers) {
      sum += number;
      result.add(sum);
    }
    return result;
  }

}